Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDA3562F44
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 10:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbiGAI62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 04:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiGAI61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:58:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A82C113D;
        Fri,  1 Jul 2022 01:58:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3596B82F31;
        Fri,  1 Jul 2022 08:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D558C341C6;
        Fri,  1 Jul 2022 08:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656665903;
        bh=VSGSbIDQK/kxZ2ztbKbd1B4wZdl/x82/g8m9KQjCmgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kh9l72IlTdmuUJnzuiVUGuQlrgoJQFNLN0k8rLJc4fD2owDFJRqvzXb2iZl/m+D7k
         r0FGrX/mh9GMAWmqQ2IKCgRd5hazlu6RudETJ8G9llIQNhmZz9rDzFXW+2iHHYLBhK
         0LNaCVDAdr2Mom7ftFZ9xmR8LYA4LKPe+hr9xgsOlzzV7JGqVWJti2zTfZOncppuaM
         yL6/IHfxgcnL16tQSYgHVdlbLD3nea0mf4JOaTk938jNPHZ7Hhtg3KA5IiYWjAM/zX
         4ZMswaaX19fZJuE9vjrATE11gDHwoKIdynv+wxoVnfbuSYXbqUDbtM92Q/ygDnbJ0O
         d5bljFXJcq3Gw==
Date:   Fri, 1 Jul 2022 10:58:17 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH v5 bpf-next 5/5] bpf/selftests: Add a selftest for
 bpf_getxattr
Message-ID: <20220701085817.7jzdyqcboj6vkl5m@wittgenstein>
References: <CAADnVQ+HhhQdcz_u8kP45Db_gUK+pOYg=jObZpLtdin=v_t9tw@mail.gmail.com>
 <20220630114549.uakuocpn7w5jfrz2@wittgenstein>
 <CACYkzJ4uiY5B09RqRFhePNXKYLmhD_F2KepEO-UZ4tQN09yWBg@mail.gmail.com>
 <20220630132635.bxxx7q654y5icd5b@wittgenstein>
 <CACYkzJ6At2T9YGgs25mbqdVUiLtOh1LabZ5Auc+oDm4605A31A@mail.gmail.com>
 <20220630134702.bn2eq3mxeiqmg2fj@wittgenstein>
 <7d42faf7-1f55-03cb-e17e-e12f7cffe3de@schaufler-ca.com>
 <CACYkzJ7fVCWFtKhFqth5CNHGTiPnS8d=T2+-xSc03UBGLgW+4Q@mail.gmail.com>
 <e95e107e-e279-6efc-0011-3995b96414af@schaufler-ca.com>
 <CAOQ4uxgyPYK78Cs_OvjNrCF3wMJ9rnZooZZPenzRN_jDs7pXwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgyPYK78Cs_OvjNrCF3wMJ9rnZooZZPenzRN_jDs7pXwQ@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 01, 2022 at 11:32:55AM +0300, Amir Goldstein wrote:
> On Fri, Jul 1, 2022 at 2:39 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > On 6/30/2022 3:23 PM, KP Singh wrote:
> > > On Thu, Jun 30, 2022 at 6:10 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > >> On 6/30/2022 6:47 AM, Christian Brauner wrote:
> > >>> On Thu, Jun 30, 2022 at 03:29:53PM +0200, KP Singh wrote:
> > >>>> On Thu, Jun 30, 2022 at 3:26 PM Christian Brauner <brauner@kernel.org> wrote:
> > >>>>> On Thu, Jun 30, 2022 at 02:21:56PM +0200, KP Singh wrote:
> > >>>>>> On Thu, Jun 30, 2022 at 1:45 PM Christian Brauner <brauner@kernel.org> wrote:
> > >>>>>>> On Wed, Jun 29, 2022 at 08:02:50PM -0700, Alexei Starovoitov wrote:
> > >>>>>>>> On Wed, Jun 29, 2022 at 2:56 AM Christian Brauner <brauner@kernel.org> wrote:
> > >>>>>> [...]
> > >>>>>>
> > >>>>>>>>>>>>>> Signed-off-by: KP Singh <kpsingh@kernel.org>
> > >>>>>>>>>>>>>> ---
> > >>>>>>>>>>>>>>  .../testing/selftests/bpf/prog_tests/xattr.c  | 54 +++++++++++++++++++
> > >>>>>>>>>>>> [...]
> > >>>>>>>>>>>>
> > >>>>>>>>>>>>>> +SEC("lsm.s/bprm_committed_creds")
> > >>>>>>>>>>>>>> +void BPF_PROG(bprm_cc, struct linux_binprm *bprm)
> > >>>>>>>>>>>>>> +{
> > >>>>>>>>>>>>>> +     struct task_struct *current = bpf_get_current_task_btf();
> > >>>>>>>>>>>>>> +     char dir_xattr_value[64] = {0};
> > >>>>>>>>>>>>>> +     int xattr_sz = 0;
> > >>>>>>>>>>>>>> +
> > >>>>>>>>>>>>>> +     xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
> > >>>>>>>>>>>>>> +                             bprm->file->f_path.dentry->d_inode, XATTR_NAME,
> > >>>>>>>>>>>>>> +                             dir_xattr_value, 64);
> > >>>>>>>>>>>>> Yeah, this isn't right. You're not accounting for the caller's userns
> > >>>>>>>>>>>>> nor for the idmapped mount. If this is supposed to work you will need a
> > >>>>>>>>>>>>> variant of vfs_getxattr() that takes the mount's idmapping into account
> > >>>>>>>>>>>>> afaict. See what needs to happen after do_getxattr().
> > >>>>>>>>>>>> Thanks for taking a look.
> > >>>>>>>>>>>>
> > >>>>>> [...]
> > >>>>>>
> > >>>>>>>>>>> That will not be correct.
> > >>>>>>>>>>> posix_acl_fix_xattr_to_user checking current_user_ns()
> > >>>>>>>>>>> is checking random tasks that happen to be running
> > >>>>>>>>>>> when lsm hook got invoked.
> > >>>>>>>>>>>
> > >>>>>>>>>>> KP,
> > >>>>>>>>>>> we probably have to document clearly that neither 'current*'
> > >>>>>>>>>>> should not be used here.
> > >>>>>>>>>>> xattr_permission also makes little sense in this context.
> > >>>>>>>>>>> If anything it can be a different kfunc if there is a use case,
> > >>>>>>>>>>> but I don't see it yet.
> > >>>>>>>>>>> bpf-lsm prog calling __vfs_getxattr is just like other lsm-s that
> > >>>>>>>>>>> call it directly. It's the kernel that is doing its security thing.
> > >>>>>>>>>> Right, but LSMs usually only retrieve their own xattr namespace (ima,
> > >>>>>>>>>> selinux, smack) or they calculate hashes for xattrs based on the raw
> > >>>>>>>>>> filesystem xattr values (evm).
> > >>>>>>>>>>
> > >>>>>>>>>> But this new bpf_getxattr() is different. It allows to retrieve _any_
> > >>>>>>>>>> xattr in any security hook it can be attached to. So someone can write a
> > >>>>>>>>>> bpf program that retrieves filesystem capabilites or posix acls. And
> > >>>>>>>>>> these are xattrs that require higher-level vfs involvement to be
> > >>>>>>>>>> sensible in most contexts.
> > >>>>>>>>>>
> > >>>>>> [...]
> > >>>>>>
> > >>>>>>>>>> This hooks a bpf-lsm program to the security_bprm_committed_creds()
> > >>>>>>>>>> hook. It then retrieves the extended attributes of the file to be
> > >>>>>>>>>> executed. The hook currently always retrieves the raw filesystem values.
> > >>>>>>>>>>
> > >>>>>>>>>> But for example any XATTR_NAME_CAPS filesystem capabilities that
> > >>>>>>>>>> might've been stored will be taken into account during exec. And both
> > >>>>>>>>>> the idmapping of the mount and the caller matter when determing whether
> > >>>>>>>>>> they are used or not.
> > >>>>>>>>>>
> > >>>>>>>>>> But the current implementation of bpf_getxattr() just ignores both. It
> > >>>>>>>>>> will always retrieve the raw filesystem values. So if one invokes this
> > >>>>>>>>>> hook they're not actually retrieving the values as they are seen by
> > >>>>>>>>>> fs/exec.c. And I'm wondering why that is ok? And even if this is ok for
> > >>>>>>>>>> some use-cases it might very well become a security issue in others if
> > >>>>>>>>>> access decisions are always based on the raw values.
> > >>>>>>>>>>
> > >>>>>>>>>> I'm not well-versed in this so bear with me, please.
> > >>>>>>>>> If this is really just about retrieving the "security.bpf" xattr and no
> > >>>>>>>>> other xattr then the bpf_getxattr() variant should somehow hard-code
> > >>>>>>>>> that to ensure that no other xattrs can be retrieved, imho.
> > >>>>>>>> All of these restrictions look very artificial to me.
> > >>>>>>>> Especially the part "might very well become a security issue"
> > >>>>>>>> just doesn't click.
> > >>>>>>>> We're talking about bpf-lsm progs here that implement security.
> > >>>>>>>> Can somebody implement a poor bpf-lsm that doesn't enforce
> > >>>>>>>> any actual security? Sure. It's a code.
> > >>>>>>> The point is that with the current implementation of bpf_getxattr() you
> > >>>>>>> are able to retrieve any xattrs and we have way less control over a
> > >>>>>>> bpf-lsm program than we do over selinux which a simple git grep
> > >>>>>>> __vfs_getxattr() is all we need.
> > >>>>>>>
> > >>>>>>> The thing is that with bpf_getxattr() as it stands it is currently
> > >>>>>>> impossible to retrieve xattr values - specifically filesystem
> > >>>>>>> capabilities and posix acls - and see them exactly like the code you're
> > >>>>>>> trying to supervise is. And that seems very strange from a security
> > >>>>>>> perspective. So if someone were to write
> > >>>>>>>
> > >>>>>>> SEC("lsm.s/bprm_creds_from_file")
> > >>>>>>> void BPF_PROG(bprm_cc, struct linux_binprm *bprm)
> > >>>>>>> {
> > >>>>>>>         struct task_struct *current = bpf_get_current_task_btf();
> > >>>>>>>
> > >>>>>>>         xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
> > >>>>>>>                                 bprm->file->f_path.dentry->d_inode,
> > >>>>>>>                                 XATTR_NAME_POSIX_ACL_ACCESS, ..);
> > >>>>>>>         // or
> > >>>>>>>         xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
> > >>>>>>>                                 bprm->file->f_path.dentry->d_inode,
> > >>>>>>>                                 XATTR_NAME_CAPS, ..);
> > >>>>>>>
> > >>>>>>> }
> > >>>>>>>
> > >>>>>>> they'd get the raw nscaps and the raw xattrs back. But now, as just a
> > >>>>>>> tiny example, the nscaps->rootuid and the ->e_id fields in the posix
> > >>>>>>> ACLs make zero sense in this context.
> > >>>>>>>
> > >>>>>>> And what's more there's no way for the bpf-lsm program to turn them into
> > >>>>>>> something that makes sense in the context of the hook they are retrieved
> > >>>>>>> in. It lacks all the necessary helpers to do so afaict.
> > >>>>>>>
> > >>>>>>>> No one complains about the usage of EXPORT_SYMBOL(__vfs_getxattr)
> > >>>>>>>> in the existing LSMs like selinux.
> > >>>>>>> Selinux only cares about its own xattr namespace. It doesn't retrieve
> > >>>>>>> fscaps or posix acls and it's not possible to write selinux programs
> > >>>>>>> that do so. With the bpf-lsm that's very much possible.
> > >>>>>>>
> > >>>>>>> And if we'd notice selinux would start retrieving random xattrs we'd ask
> > >>>>>>> the same questions we do here.
> > >>>>>>>
> > >>>>>>>> No one complains about its usage in out of tree LSMs.
> > >>>>>>>> Is that a security issue? Of course not.
> > >>>>>>>> __vfs_getxattr is a kernel mechanism that LSMs use to implement
> > >>>>>>>> the security features they need.
> > >>>>>>>> __vfs_getxattr as kfunc here is pretty much the same as EXPORT_SYMBOL
> > >>>>>>>> with a big difference that it's EXPORT_SYMBOL_GPL.
> > >>>>>>>> BPF land doesn't have an equivalent of non-gpl export and is not going
> > >>>>>>>> to get one.
> > >>>>>> I want to reiterate what Alexei is saying here:
> > >>>>>>
> > >>>>>> *Please* consider this as a simple wrapper around __vfs_getxattr
> > >>>>>> with a limited attach surface and extra verification checks and
> > >>>>>> and nothing else.
> > >>>>>>
> > >>>>>> What you are saying is __vfs_getxattr does not make sense in some
> > >>>>>> contexts. But kernel modules can still use it right?
> > >>>>>>
> > >>>>>> The user is implementing an LSM, if they chose to do things that don't make
> > >>>>>> sense, then they can surely cause a lot more harm:
> > >>>>>>
> > >>>>>> SEC("lsm/bprm_check_security")
> > >>>>>> int BPF_PROG(bprm_check, struct linux_binprm *bprm)
> > >>>>>> {
> > >>>>>>      return -EPERM;
> > >>>>>> }
> > >>>>>>
> > >>>>>>> This discussion would probably be a lot shorter if this series were sent
> > >>>>>>> with a proper explanation of how this supposed to work and what it's
> > >>>>>>> used for.
> > >>>>>> It's currently scoped to BPF LSM (albeit limited to LSM for now)
> > >>>>>> but it won't just be used in LSM programs but some (allow-listed)
> > >>>>>> tracing programs too.
> > >>>>>>
> > >>>>>> We want to leave the flexibility to the implementer of the LSM hooks. If the
> > >>>>>> implementer choses to retrieve posix_acl_* we can also expose
> > >>>>>> posix_acl_fix_xattr_to_user or a different kfunc that adds this logic too
> > >>>>>> but that would be a separate kfunc (and a separate use-case).
> > >>>>> No, sorry. That's what I feared and that's why I think this low-level
> > >>>>> exposure of __vfs_getxattr() is wrong:
> > >>>>> The posix_acl_fix_xattr_*() helpers, as well as the helpers like
> > >>>>> get_file_caps() will not be exported. We're not going to export that
> > >>>> I don't want to expose them and I don't want any others to be
> > >>>> exposed either.
> > >>>>
> > >>>>> deeply internal vfs machinery. So I would NACK that. If you want that -
> > >>>>> and that's what I'm saying here - you need to encapsulate this into your
> > >>>>> vfs_*xattr() helper that you can call from your kfuncs.
> > >>>> It seems like __vfs_getxattr is already exposed and does the wrong thing in
> > >>>> some contexts, why can't we just "fix" __vfs_getxattr then?
> > >>> To me having either a version of bpf_getxattr() that restricts access to
> > >>> certain xattrs or a version that takes care to perform the neccesary
> > >>> translations is what seems to make the most sense. I suggested that in
> > >>> one of my first mails.
> > >>>
> > >>> The one thing where the way the xattrs are retrieved really matters is
> > >>> for vfscaps (see get_vfs_caps_from_disk()) you really need something
> > >>> like that function in order for vfs caps to make any sense and be
> > >>> interpretable by the user of the hook.
> > >>>
> > >>> But again, I might just misunderstand the context here and for the
> > >>> bpf-lsm all of this isn't really a concern. If your new series comes out
> > >>> I'll try to get more into the wider context.
> > >>> If the security folks are happy with this then I won't argue.
> > >> A security module (BPF) using another security module's (Smack)
> > >> xattrs without that module's (Smack) explicit approval would be
> > >> considered extremely rude.  Smack and SELinux use published interfaces
> > >> of the capability security module, but never access the capability
> > >> attributes directly. The details of a security module's implementation
> > >> are not a factor. The fact that BPF uses loadable programs as opposed
> > >> to loadable policy is not relevant. The only security.xattr values
> > >> that the BPF security module should allow the programs it runs to
> > >> access are the ones it is managing. If you decided to create an eBPF
> > > What about kernel modules who can use __vfs_getxattr already as
> > > it's an exported symbol? This can still end up influencing
> > > security policy or using them in any way they like.
> >
> > If I put code in Smack to read SELinux attributes I would expect
> > to get a possibly polite but definitely strongly worded email
> > from Paul Moore regarding that behavior. The integrity subsystem
> > looks at Smack and SELinux attributes, but that's upstream and
> > we can see what nefarious things are being done with them. Because
> > I can see the upstream kernel code I can convince myself that
> > regardless of the SELinux policy loaded SELinux isn't going to
> > muck with the Smack attributes. I can't say the same for eBPF
> > programs that aren't going to be in Linus' tree.
> >
> > > Anyways, I think, for now, for the use case we have, it can work with
> > > a restriction to security.bpf xattrs.
> >
> > I can't say that this whole discussion is making me feel better
> > about the BPF LSM concept. The approval was based on the notion
> > that eBPF programs were restricted to "safe" behavior. It's
> > hard to see how allowing access to security.selinux could be
> > guaranteed to be in support of safe behavior.
> >
> 
> Apropos __vfs_getxattr(), looks like ecryptfs_getxattr_lower()
> is abusing it.

Heh, quoting what I wrote to KP yesterday off-list about
__vfs_getxattr():

"it's [__vfs_getxattr()] exported but [afaict] it's not used in kernel
modules. afaict it's only exposed because of ecryptfs"

So right at the beginning I had already pondered whether we should just
rip out __vfs_getxattr() from ecryptfs and unexport the helper
completely because there's barely a reason to use it. Module/driver code
should not use something as low-level as __vfs_getxattr() imho.

Overlayfs does it correctly and uses vfs_getxattr() but maybe ecryptfs
needs to use it for for some reason?. I haven't looked yet.

> Christian, not sure if you intend to spend time of idmapped
> mount support of ecryptfs lower layer, but anyway that's that.

Not really. Remember the conversation we had with Tyler at LSFMM where
he considered marking it deprecated. I don't think it's worth putting in
the work.
