Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068CB2B9663
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 16:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgKSPj3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 10:39:29 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45058 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbgKSPj2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:39:28 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kfm1l-00008C-0z; Thu, 19 Nov 2020 15:39:17 +0000
Date:   Thu, 19 Nov 2020 16:39:15 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>, mauricio@kinvolk.io,
        Alban Crequy <alban.crequy@gmail.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Anderson <kylea@netflix.com>
Subject: Re: [PATCH v5 2/2] NFSv4: Refactor to use user namespaces for
 nfs4idmap
Message-ID: <20201119153915.5o3qe7lsvkchxv4n@wittgenstein>
References: <20201112100952.3514-1-sargun@sargun.me>
 <20201112100952.3514-3-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201112100952.3514-3-sargun@sargun.me>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry for chiming in, but Sargun, Alban and I had a chat about this
yesterday and so I took a closer at this patch and NFS today.

On Thu, Nov 12, 2020 at 02:09:52AM -0800, Sargun Dhillon wrote:
> In several patches work has been done to enable NFSv4 to use user
> namespaces:
> 58002399da65: NFSv4: Convert the NFS client idmapper to use the container user namespace
> 3b7eb5e35d0f: NFS: When mounting, don't share filesystems between different user namespaces
> 
> Unfortunately, the userspace APIs were only such that the userspace facing
> side of the filesystem (superblock s_user_ns) could be set to a non init
> user namespace. This furthers the fs_context related refactoring, and
> piggybacks on top of that logic, so the superblock user namespace, and the
> NFS user namespace are the same.

The s_user_ns aka the user namespace of the superblock is taken from the
struct fs_context->user_ns. This struct is created during fsopen() and
it records the caller's credentials in fs_context->cred and the caller's
user namespace in fs_context->cred->user_ns.

Actual creation of a new superblock happens during
fsconfig(FSCONFIG_CMD_CREATE) which checks whether the caller is
privileged wrt to the fs_context->user_ns if the filesystem is
FS_USERNS_MOUNT and otherwise requires capabilities in the initial user
namespace. The latter applies to NFS.

From fsconfig(FSCONFIG_CMD_CREATE() the vfs calls into the filesystem
specific ->get_tree() methods which for NFS lands us in
nfs_get_tree_common() which calls into sget_fc(). This sets
sb->s_user_ns to fc->user_ns and thus to the user_ns of the creator of
the fs_context from the original fsopen() call.

However, when a new nfs server is created the initial user namespace is
used to stash the current clients credentials and this indeed feels like
a bug. So it seems like the change here makes sense.

> 
> Users can still use rpc.idmapd if they choose to, but there are complexities
> with user namespaces and request-key that have yet to be addresssed.
> 
> Eventually, we will need to at least:
>   * Separate out the keyring cache by namespace
>   * Come up with an upcall mechanism that can be triggered inside of the container,
>     or safely triggered outside, with the requisite context to do the right
>     mapping. * Handle whatever refactoring needs to be done in net/sunrpc.

I think this whole section is orthogonal to the problem solved here,
especially since I think the patch fixes a bug while enabling a use-case
that should've likely worked before. There's no need tie these things
together. Maybe the paragraph I have below makes this a little more
obvious.

> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Tested-by: Alban Crequy <alban.crequy@gmail.com>
> ---
>  fs/nfs/nfs4client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index be7915c861ce..86acffe7335c 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -1153,7 +1153,7 @@ struct nfs_server *nfs4_create_server(struct fs_context *fc)
>  	if (!server)
>  		return ERR_PTR(-ENOMEM);
>  
> -	server->cred = get_cred(current_cred());
> +	server->cred = get_cred(fc->cred);
>  
>  	auth_probe = ctx->auth_info.flavor_len < 1;

So I looked at what file creation does involve and I'm not an nfs expert
so I may be off and I trust people will yell at me if I am.

When a new file is created and the vfs part is done, the name and group
is retrieved which is supposed to be used for file creation. The
retrieved name and group is then translated in a first step via the
upcall mechanism. (This first translation is technically equivalent to
reading raw device ids from disk for other filesystems.) But this
translation part is not really relevant to the problem here.

The interesting part for this fix is the step that happens when the raw
ids are translated into their kernel representations aka kuid and kgid
which is ultimately used to initialize i_uid and i_gid.
The raw device ids are translated based on server->nfs_client->cl_idmap.
Afaict, the cl_idmap is setup based on server->creds and
server->creds->user_ns. And that's when things get weird because
server->creds are the callers credentials not the fsopen() credentials.
Similarly the "wrong" creds are used when translating from the in-kernel
to the userspace representation later on.

If it is intentional that server->cred uses the caller's creds by
default and there's a fear of regressions then one option could be to
add a mount option to NFS that indicates that the creator's credentials
are supposed to be used. This might be interesting in so far, as it
makes the intent to delegate the new client to another user more
explicit. But whether that makes sense really depends on whether or not
this used to work before or not, I guess.

In general, this solves a mapping problem specific to the nfs client it
seems to me and looks fine, I think.

This is the rough callchain I based my analysis on:

i_op->create()::nfs_create()
-> NFS_PROTO(dir)->create()::nfs_v4_clientops->create()::nfs4_proc_create()
   -> alloc_nfs_open_context()
      ->  if (filp)
                  ctx->cred = get_cred(filp->f_cred);
          else
                  ctx->cred = get_current_cred();
   -> nfs4_do_open()
      -> _nfs4_do_open()
         -> nfs4_get_state_owner()
            /* The state is owned by ctx->cred and it is compared against server->cred. */
      -> _nfs4_open_and_get_state()
	 /* Set owner_name. */
         -> _nfs4_proc_open()
	    -> nfs4_run_open_task()
	       -> nfs4_procedures[NFSPROC4_CLNT_OPEN]::
                  -> nfs4_xdr_enc_open()
                     -> encode_getfattr_open()
                        -> encode_getattr()
	    /* 
	     * Lookup the uid based on the name and store in fattr->uid.
	     * fattr->uid is used to initialize i_uid later after having been
	     * mapped is then used to initialize i_uid.
	     */
            -> nfs_fattr_map_and_free_names()
               -> nfs_fattr_map_owner_name()
                  -> nfs_map_name_to_uid()
                     -> nfs_map_string_to_numeric() /* Try to parse the name as a uid. */
                     ->  nfs_idmap_lookup_id() /* Lookup ids upcall mechanism. */
                         -> nfs_idmap_get_key() 
                            -> nfs_idmap_request_key()
                               -> nfs_idmap_get_desc()
                               -> request_key_with_auxdata()/request_key()
		     -> fattr->uid = make_kuid(idmap_userns(idmap), id); Turn raw device id into kuids. */
         -> _nfs4_opendata_to_nfs4_state()
            -> nfs4_opendata_find_nfs4_state()
               -> nfs4_opendata_get_inode()
                  -> nfs_fhget()
                     -> iget5_locked()
                     /* Initialize i_uid to INVALID_UID. */
                     -> inode->i_uid = make_kuid(&init_user_ns, -2);
                        /* Initialize i_uid according to fattr. */
                        if (fattr->valid & NFS_ATTR_FATTR_OWNER)
                                inode->i_uid = fattr->uid;
         -> nfs4_do_setattr()
            -> _nfs4_do_setattr()
               -> nfs4_procedures[NFSPROC4_CLNT_SETATTR]::nfs4_xdr_enc_setattr()
                  -> encode_setattr()
                     -> encode_attrs()
                        -> nfs_map_uid_to_name()
                           -> struct idmap *idmap = server->nfs_client->cl_idmap;
                              id = from_kuid_munged(idmap_userns(idmap), uid);
         -> nfs_setattr_update_inode()
            -> if ((attr->ia_valid & ATTR_UID) != 0)
                       inode->i_uid = attr->ia_uid;
            -> nfs_update_inode()
               -> inode->i_uid = fattr->uid;

Christian
