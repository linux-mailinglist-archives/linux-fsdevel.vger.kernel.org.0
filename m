Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3986730E88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 07:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243116AbjFOFJ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 01:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbjFOFJU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:09:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD446268C
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 22:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686805710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s+ikUzfGveEiyGA/jVsN5eVawRdl7xzTb1qRqNt76aA=;
        b=X5j53a7lxnO0AnRUlhNonmIDsdbnVAh3tJG1fhpG9coKjGL8Axc2teI82D7WhsFxG+jZRQ
        fcJk4MOjr8BXRANPpCGERmqu/geBv7clprFbNBN4dFp2PxInqxvZrtaaAKZPqbWV/Y9kZB
        QzCElwvhcsUE67DdsblMnGSpDkMajrw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-T3cBQwemOiuVsFTuciSDFg-1; Thu, 15 Jun 2023 01:08:29 -0400
X-MC-Unique: T3cBQwemOiuVsFTuciSDFg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75caeec5545so447224885a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 22:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686805709; x=1689397709;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+ikUzfGveEiyGA/jVsN5eVawRdl7xzTb1qRqNt76aA=;
        b=g0AdjvNUZ/RCn2EM4r6KjQN3q58AbYrBbfwUkdHkdzZ1oR4j9uuHJxVjhi1+QusrQS
         B5v5XVtLiBhV0D6K1DMfUgnU8ib1+82tZhBzijl6+5OEnokHGNnu+DZOoLZ36tANOZmz
         +4APe9FBce2qy5Dlqhd4NNpvIFYzom54Hqshwz3WHi8S845u4UPxPF/bpyApKbaz7WC3
         bOu4oVoUqufgI3De+y0b5++DrbZ2cdopn8K41n2L0xl96tLsNoTYvlFK8rXcLymvMF9V
         P50HzxlVUBrCKr2E+F404oEr3p4cmUlCgqfMVErEc8hSpOEtB7NejJDFAOXL6y6arf8y
         cbUg==
X-Gm-Message-State: AC+VfDyGhDuGhSmn3O53ggKh4Xhu0m1X/ouHkAXyLlRd91UVd1qMMWJd
        vqEmhTKP/NiIZVQj1uhkDHMEdJlxD5kmHr1ISZp2UA6Upzomu+cQuvjTnQhax/shNhA3LtUvHDo
        LSxfjUIDSBHH3F9jtqZD/0wfm1p52mVbFaxvM
X-Received: by 2002:a05:620a:56a:b0:75e:fda5:cbd0 with SMTP id p10-20020a05620a056a00b0075efda5cbd0mr17955911qkp.12.1686805708707;
        Wed, 14 Jun 2023 22:08:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7P/CitXl6sr13gP+gUAcph8PGaMfYhMEf5lBHfcRFgKHD3+OmpiM75c92ji0VEMFSoJTubfw==
X-Received: by 2002:a05:620a:56a:b0:75e:fda5:cbd0 with SMTP id p10-20020a05620a056a00b0075efda5cbd0mr17955898qkp.12.1686805708321;
        Wed, 14 Jun 2023 22:08:28 -0700 (PDT)
Received: from [10.72.12.155] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v6-20020aa78506000000b00640defda6d2sm11136194pfn.207.2023.06.14.22.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 22:08:27 -0700 (PDT)
Message-ID: <626175e2-ee91-0f1a-9e5d-e506aea366fa@redhat.com>
Date:   Thu, 15 Jun 2023 13:08:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 00/14] ceph: support idmapped mounts
Content-Language: en-US
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     Gregory Farnum <gfarnum@redhat.com>,
        Christian Brauner <brauner@kernel.org>, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
 <f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com>
 <CAEivzxcRsHveuW3nrPnSBK6_2-eT4XPvza3kN2oogvnbVXBKvQ@mail.gmail.com>
 <20230609-alufolie-gezaubert-f18ef17cda12@brauner>
 <CAEivzxc_LW6mTKjk46WivrisnnmVQs0UnRrh6p0KxhqyXrErBQ@mail.gmail.com>
 <ac1c6817-9838-fcf3-edc8-224ff85691e0@redhat.com>
 <CAJ4mKGby71qfb3gd696XH3AazeR0Qc_VGYupMznRH3Piky+VGA@mail.gmail.com>
 <977d8133-a55f-0667-dc12-aa6fd7d8c3e4@redhat.com>
 <CAEivzxcr99sERxZX17rZ5jW9YSzAWYvAjOOhBH+FqRoso2=yng@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAEivzxcr99sERxZX17rZ5jW9YSzAWYvAjOOhBH+FqRoso2=yng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 6/14/23 20:34, Aleksandr Mikhalitsyn wrote:
> On Wed, Jun 14, 2023 at 3:53 AM Xiubo Li <xiubli@redhat.com> wrote:
> >
> >
> > On 6/13/23 22:53, Gregory Farnum wrote:
> > > On Mon, Jun 12, 2023 at 6:43 PM Xiubo Li <xiubli@redhat.com> wrote:
> > >>
> > >> On 6/9/23 18:12, Aleksandr Mikhalitsyn wrote:
> > >>> On Fri, Jun 9, 2023 at 12:00 PM Christian Brauner 
> <brauner@kernel.org> wrote:
> > >>>> On Fri, Jun 09, 2023 at 10:59:19AM +0200, Aleksandr Mikhalitsyn 
> wrote:
> > >>>>> On Fri, Jun 9, 2023 at 3:57 AM Xiubo Li <xiubli@redhat.com> wrote:
> > >>>>>> On 6/8/23 23:42, Alexander Mikhalitsyn wrote:
> > >>>>>>> Dear friends,
> > >>>>>>>
> > >>>>>>> This patchset was originally developed by Christian Brauner 
> but I'll continue
> > >>>>>>> to push it forward. Christian allowed me to do that :)
> > >>>>>>>
> > >>>>>>> This feature is already actively used/tested with LXD/LXC 
> project.
> > >>>>>>>
> > >>>>>>> Git tree (based on https://github.com/ceph/ceph-client.git 
> master):
> > >>>>> Hi Xiubo!
> > >>>>>
> > >>>>>> Could you rebase these patches to 'testing' branch ?
> > >>>>> Will do in -v6.
> > >>>>>
> > >>>>>> And you still have missed several places, for example the 
> following cases:
> > >>>>>>
> > >>>>>>
> > >>>>>>       1    269  fs/ceph/addr.c <<ceph_netfs_issue_op_inline>>
> > >>>>>>                 req = ceph_mdsc_create_request(mdsc, 
> CEPH_MDS_OP_GETATTR,
> > >>>>>> mode);
> > >>>>> +
> > >>>>>
> > >>>>>>       2    389  fs/ceph/dir.c <<ceph_readdir>>
> > >>>>>>                 req = ceph_mdsc_create_request(mdsc, op, 
> USE_AUTH_MDS);
> > >>>>> +
> > >>>>>
> > >>>>>>       3    789  fs/ceph/dir.c <<ceph_lookup>>
> > >>>>>>                 req = ceph_mdsc_create_request(mdsc, op, 
> USE_ANY_MDS);
> > >>>>> We don't have an idmapping passed to lookup from the VFS 
> layer. As I
> > >>>>> mentioned before, it's just impossible now.
> > >>>> ->lookup() doesn't deal with idmappings and really can't 
> otherwise you
> > >>>> risk ending up with inode aliasing which is really not 
> something you
> > >>>> want. IOW, you can't fill in inode->i_{g,u}id based on a mount's
> > >>>> idmapping as inode->i_{g,u}id absolutely needs to be a 
> filesystem wide
> > >>>> value. So better not even risk exposing the idmapping in there 
> at all.
> > >>> Thanks for adding, Christian!
> > >>>
> > >>> I agree, every time when we use an idmapping we need to be 
> careful with
> > >>> what we map. AFAIU, inode->i_{g,u}id should be based on the 
> filesystem
> > >>> idmapping (not mount),
> > >>> but in this case, Xiubo want's current_fs{u,g}id to be mapped
> > >>> according to an idmapping.
> > >>> Anyway, it's impossible at now and IMHO, until we don't have any
> > >>> practical use case where
> > >>> UID/GID-based path restriction is used in combination with idmapped
> > >>> mounts it's not worth to
> > >>> make such big changes in the VFS layer.
> > >>>
> > >>> May be I'm not right, but it seems like UID/GID-based path 
> restriction
> > >>> is not a widespread
> > >>> feature and I can hardly imagine it to be used with the container
> > >>> workloads (for instance),
> > >>> because it will require to always keep in sync MDS permissions
> > >>> configuration with the
> > >>> possible UID/GID ranges on the client. It looks like a nightmare 
> for sysadmin.
> > >>> It is useful when cephfs is used as an external storage on the 
> host, but if you
> > >>> share cephfs with a few containers with different user 
> namespaces idmapping...
> > >> Hmm, while this will break the MDS permission check in cephfs then in
> > >> lookup case. If we really couldn't support it we should make it to
> > >> escape the check anyway or some OPs may fail and won't work as 
> expected.
> > > I don't pretend to know the details of the VFS (or even our linux
> > > client implementation), but I'm confused that this is apparently so
> > > hard. It looks to me like we currently always fill in the "caller_uid"
> > > with "from_kuid(&init_user_ns, req->r_cred->fsuid))". Is this actually
> > > valid to begin with? If it is, why can't the uid mapping be applied on
> > > that?
> > >
> > > As both the client and the server share authority over the inode's
> > > state (including things like mode bits and owners), and need to do
> > > permission checking, being able to tell the server the relevant actor
> > > is inherently necessary. We also let admins restrict keys to
> > > particular UID/GID combinations as they wish, and it's not the most
> > > popular feature but it does get deployed. I would really expect a user
> > > of UID mapping to be one of the *most* likely to employ such a
> > > facility...maybe not with containers, but certainly end-user homedirs
> > > and shared spaces.
> > >
> > > Disabling the MDS auth checks is really not an option. I guess we
> > > could require any user employing idmapping to not be uid-restricted,
> > > and set the anonymous UID (does that work, Xiubo, or was it the broken
> > > one? In which case we'd have to default to root?). But that seems a
> > > bit janky to me.
> >
> > Yeah, this also seems risky.
> >
> > Instead disabling the MDS auth checks there is another option, which is
> > we can prevent  the kclient to be mounted or the idmapping to be
> > applied. But this still have issues, such as what if admins set the MDS
> > auth caps after idmap applied to the kclients ?
>
> Hi Xiubo,
>
> I thought about this too and came to the same conclusion, that UID/GID 
> based
> restriction can be applied dynamically, so detecting it on mount-time 
> helps not so much.
>
For this you please raise one PR to ceph first to support this, and in 
the PR we can discuss more for the MDS auth caps. And after the PR 
getting merged then in this patch series you need to check the 
corresponding option or flag to determine whether could the idmap 
mounting succeed.

Thanks

- Xiubo


> >
> > IMO there have 2 options: the best way is to fix this in VFS if
> > possible. Else to add one option to disable the corresponding MDS auth
> > caps in ceph if users want to support the idmap feature.
>
> Dear colleagues,
> Dear Xiubo,
>
> Let me try to summarize the previous discussions about cephfs idmapped 
> mount support.
>
> This discussion about the need of caller's UID/GID mapping is started 
> from the first
> version of this patchset in this [1] thread. Let'me quote Christian here:
> > Since the idmapping is a property of the mount and not a property of the
> > caller the caller's fs{g,u}id aren't mapped. What is mapped are the
> > inode's i{g,u}id when accessed from a particular mount.
> >
> > The fs{g,u}id are only ever mapped when a new filesystem object is
> > created. So if I have an idmapped mount that makes it so that files
> > owned by 1000 on-disk appear to be owned by uid 0 then a user with uid 0
> > creating a new file will create files with uid 1000 on-disk when going
> > through that mount. For cephfs that'd be the uid we would be sending
> > with creation requests as I've currently written it.
>
> This is a key part of this discussion. Idmapped mounts is not a way to 
> proxify
> caller's UID/GID, but idmapped mounts are designed to perform UID/GID 
> mapping
> of inode's owner's UID/GID. Yes, these concepts look really-really 
> close and from
> the first glance it looks like it's just an equivalent thing. But they 
> are not.
>
> From my understanding, if someone wants to verify caller UID/GID then 
> he should
> take an unmapped UID/GID and verify it. It's not important if the 
> caller does something
> through an idmapped mount or not, from_kuid(&init_user_ns, 
> req->r_cred->fsuid))
> literally "UID of the caller in a root user namespace". But cephfs 
> mount can be used
> from any user namespace (yes, cephfs can't be mounted in user 
> namespaces, but it
> can be inherited during CLONE_NEWNS, or used as a detached mount with 
> open_tree/move_mount).
> What I want to say by providing this example is that even now, without 
> idmapped mounts
> we have kinda close problem, that UID/GID based restriction will be 
> based on the host's (!),
> root user namespace, UID/GID-s even if the caller sits inside the user 
> namespace. And we don't care,
> right? Why it's a problem with an idmapped mounts? If someone wants to 
> control caller's UID/GID
> on the MDS side he just needs to take hosts UID/GIDs and use them in 
> permission rules. That's it.
>
> Next point is that technically idmapped mounts don't break anything, 
> if someone starts using
> idmapped mounts with UID/GID-based restrictions he will get -EACCESS. 
> Why is this a problem?
> A user will check configuration, read the clarification in the 
> documentation about idmapped mounts
> in cephfs and find a warning that these are not fully compatible 
> things right now.
>
> IMHO, there is only one real problem (which makes UID/GID-based 
> restrictions is not fully compatible with
> an idmapped mounts). Is that we have to map caller's UID/GID according 
> to a mount idmapping when we
> creating a new inode (mknod, mkdir, symlink, open(O_CREAT)). But it's 
> only because the caller's UID/GIDs are
> used as the owner's UID/GID for newly created inode. Ideally, we need 
> to have two fields in ceph request,
> one for a caller's UID/GID and another one for inode owner UID/GID. 
> But this requires cephfs protocol modification
> (yes, it's a bit painful. But global VFS changes are painful too!). As 
> Christian pointed this is a reason why
> he went this way in the first patchset version.
>
> Maybe I'm not right, but both options to properly fix that VFS API 
> changes or cephfs protocol modification
> are too expensive until we don't have a real requestors with a good 
> use case for idmapped mounts + UID/GID
> based permissions. We already have a real and good use case for 
> idmapped mounts in Cephfs for LXD/LXC.
> IMHO, it's better to move this thing forward step by step, because VFS 
> API/cephfs protocol changes will
> take a really big amount of time and it's not obvious that it's worth 
> it, moreover it's not even clear that VFS API
> change is the right way to deal with this problem. It seems to me that 
> Cephfs protocol change seems like a
> more proper way here. At the same time I fully understand that you are 
> not happy about this option.
>
> Just to conclude, we don't have any kind of cephfs degradation here, 
> all users without idmapping will not be affected,
> all users who start using mount idmappings with cephfs will be aware 
> of this limitation.
>
> [1] 
> https://lore.kernel.org/all/20220105141023.vrrbfhti5apdvkz7@wittgenstein/
>
> Kind regards,
> Alex
>
> >
> > Thanks
> >
> > - Xiubo
> >
> > > -Greg
> > >
> > >> @Greg
> > >>
> > >> For the lookup requests the idmapping couldn't get the mapped UID/GID
> > >> just like all the other requests, which is needed by the MDS 
> permission
> > >> check. Is that okay to make it disable the check for this case ? I am
> > >> afraid this will break the MDS permssions logic.
> > >>
> > >> Any idea ?
> > >>
> > >> Thanks
> > >>
> > >> - Xiubo
> > >>
> > >>
> > >>> Kind regards,
> > >>> Alex
> > >>>
> >

