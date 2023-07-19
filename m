Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A965175A082
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 23:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjGSVW2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 17:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjGSVW1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:22:27 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1B71FD2;
        Wed, 19 Jul 2023 14:22:25 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b702319893so984701fa.3;
        Wed, 19 Jul 2023 14:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689801743; x=1692393743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pJlm+cK7svZ1+mHOBH75gskGJmblFGpUfmfoGmUCm8o=;
        b=VS+Uoeq0DWSXf7XqdrtJWwPfD3woLqRezpI2fCqDZOSP+XFOa+C8h2OX8JLqHv+VMn
         T9GZo+0vo/HihuA2LjQBQd+KU1iF1aDGHbie6gManZZJxAPX9Frxv/bG/2Zhc7vpJ8Eh
         pkXsbFYpAEfHPdsLsNsxJvBx2PxXId4bRKEzYtIBkn0N9d5fPKUk0YIhf6/nZL3efH0h
         SLxGuhlvmARirG4XJFcXF5Mj6rWub8StEuUuUTa/N5oOzctFDDz6rCX3CK93iGZPCQj8
         PFxYLYPdADcJllOBFI5p0P+Qrzo/Ma5wDNJYk+Y3E6+6l9HB6szxBYvisvYWGJec8f1X
         3ZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689801743; x=1692393743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJlm+cK7svZ1+mHOBH75gskGJmblFGpUfmfoGmUCm8o=;
        b=Mg6drLWLBWk3eyowwmQyVCMbD8Yr/mhHDEN7QQIsufqmJ2MsuoECRVVuu06AQ/9Wr2
         chrKAe34ELh3lkyB54zHNQHW0XoGevjzeb5uMjhCLkWT7wusvp4E0n2zocj5qGdlkgUW
         D96ePLsFwKRlYo1DZBnC+7K+nB1LCNPviZaFwyW5lqa7zuxk8xnOhUYiCwFBo8pfdtO3
         JwPU+ktNRUUTuHSHQyhtDoPNcBrFe7Vehp7J1iLhuyRP206YxpZW5C57PawTaSUKSx+7
         jVYroX9agY5ThVJCWdcb97nKyB1qQ0PYKeRJXObJCvl7GUV+I0h1Z2DYS+ubbfMB1BFt
         p9Bw==
X-Gm-Message-State: ABy/qLZKsP8MiCahNo8kX0HVNqPz6Oy4CgQE3Gap6W2R+dhWkOgFwspW
        brZMTWZfhLVAwdMnpALB4DzIIO8bjxKsz4xPuas=
X-Google-Smtp-Source: APBJJlEte7wDHVx/7CCyhGbmcGxCBZKgA8C7oEisNnlOb1KnVNDN2HzYFr1LRSskWr1GmqvIAsATk8NKUz6F8o8MtdI=
X-Received: by 2002:a2e:9643:0:b0:2b6:ec2a:a67e with SMTP id
 z3-20020a2e9643000000b002b6ec2aa67emr742682ljh.53.1689801743017; Wed, 19 Jul
 2023 14:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230719-nfsd-acl-v1-1-eb0faf3d2917@kernel.org>
In-Reply-To: <20230719-nfsd-acl-v1-1-eb0faf3d2917@kernel.org>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Wed, 19 Jul 2023 23:22:11 +0200
Message-ID: <CAHpGcMLJ6Auk_i4AsWe3R1rvSVr8BgqtZwyFzKCJjGKtWBWi6w@mail.gmail.com>
Subject: Re: [PATCH] nfsd: inherit required unset default acls from effective set
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ondrej Valousek <ondrej.valousek@diasemi.com>,
        Andreas Gruenbacher <agruen@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeff,

this patch seems useful, thanks.

Am Mi., 19. Juli 2023 um 19:56 Uhr schrieb Jeff Layton <jlayton@kernel.org>:
> A well-formed NFSv4 ACL will always contain OWNER@/GROUP@/EVERYONE@
> ACEs, but there is no requirement for inheritable entries for those
> entities. POSIX ACLs must always have owner/group/other entries, even for a
> default ACL.

NFSv4 ACLs actually don't *need* to have OWNER@/GROUP@/EVERYONE@
entries; that's merely a result of translating POSIX ACLs (or file
modes) to NFSv4 ACLs.

> nfsd builds the default ACL from inheritable ACEs, but the current code
> just leaves any unspecified ACEs zeroed out. The result is that adding a
> default user or group ACE to an inode can leave it with unwanted deny
> entries.
>
> For instance, a newly created directory with no acl will look something
> like this:
>
>         # NFSv4 translation by server
>         A::OWNER@:rwaDxtTcCy
>         A::GROUP@:rxtcy
>         A::EVERYONE@:rxtcy
>
>         # POSIX ACL of underlying file
>         user::rwx
>         group::r-x
>         other::r-x
>
> ...if I then add new v4 ACE:
>
>         nfs4_setfacl -a A:fd:1000:rwx /mnt/local/test
>
> ...I end up with a result like this today:
>
>         user::rwx
>         user:1000:rwx
>         group::r-x
>         mask::rwx
>         other::r-x
>         default:user::---
>         default:user:1000:rwx
>         default:group::---
>         default:mask::rwx
>         default:other::---
>
>         A::OWNER@:rwaDxtTcCy
>         A::1000:rwaDxtcy
>         A::GROUP@:rxtcy
>         A::EVERYONE@:rxtcy
>         D:fdi:OWNER@:rwaDx
>         A:fdi:OWNER@:tTcCy
>         A:fdi:1000:rwaDxtcy
>         A:fdi:GROUP@:tcy
>         A:fdi:EVERYONE@:tcy
>
> ...which is not at all expected. Adding a single inheritable allow ACE
> should not result in everyone else losing access.
>
> The setfacl command solves a silimar issue by copying owner/group/other
> entries from the effective ACL when none of them are set:
>
>     "If a Default ACL entry is created, and the  Default  ACL  contains  no
>      owner,  owning group,  or  others  entry,  a  copy of the ACL owner,
>      owning group, or others entry is added to the Default ACL.
>
> Having nfsd do the same provides a more sane result (with no deny ACEs
> in the resulting set):
>
>         user::rwx
>         user:1000:rwx
>         group::r-x
>         mask::rwx
>         other::r-x
>         default:user::rwx
>         default:user:1000:rwx
>         default:group::r-x
>         default:mask::rwx
>         default:other::r-x
>
>         A::OWNER@:rwaDxtTcCy
>         A::1000:rwaDxtcy
>         A::GROUP@:rxtcy
>         A::EVERYONE@:rxtcy
>         A:fdi:OWNER@:rwaDxtTcCy
>         A:fdi:1000:rwaDxtcy
>         A:fdi:GROUP@:rxtcy
>         A:fdi:EVERYONE@:rxtcy

This resulting NFSv4 ACL is still rather dull; we end up with an
inherit-only entry for each effective entry. Those could all be
combined, resulting in:

         A:fd:OWNER@:rwaDxtTcCy
         A:fd:1000:rwaDxtcy
         A:fd:GROUP@:rxtcy
         A:fd:EVERYONE@:rxtcy

This will be the common case, so maybe matching entry pairs can either
be recombined or not generated in the first place as a further
improvement.

> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2136452
> Reported-by: Ondrej Valousek <ondrej.valousek@diasemi.com>
> Suggested-by: Andreas Gruenbacher <agruen@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4acl.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
> index 518203821790..64e45551d1b6 100644
> --- a/fs/nfsd/nfs4acl.c
> +++ b/fs/nfsd/nfs4acl.c
> @@ -441,7 +441,8 @@ struct posix_ace_state_array {
>   * calculated so far: */
>
>  struct posix_acl_state {
> -       int empty;
> +       bool empty;
> +       unsigned char valid;

Hmm, "valid" is a bitmask here but it only matters whether it is zero.
Shouldn't a bool be good enough? Also, this variable indicates whether
special "who" values are present (and which), so the name "valid"
probably isn't the best choice.

>         struct posix_ace_state owner;
>         struct posix_ace_state group;
>         struct posix_ace_state other;
> @@ -457,7 +458,7 @@ init_state(struct posix_acl_state *state, int cnt)
>         int alloc;
>
>         memset(state, 0, sizeof(struct posix_acl_state));
> -       state->empty = 1;
> +       state->empty = true;
>         /*
>          * In the worst case, each individual acl could be for a distinct
>          * named user or group, but we don't know which, so we allocate
> @@ -624,7 +625,7 @@ static void process_one_v4_ace(struct posix_acl_state *state,
>         u32 mask = ace->access_mask;
>         int i;
>
> -       state->empty = 0;
> +       state->empty = false;
>
>         switch (ace2type(ace)) {
>         case ACL_USER_OBJ:
> @@ -633,6 +634,7 @@ static void process_one_v4_ace(struct posix_acl_state *state,
>                 } else {
>                         deny_bits(&state->owner, mask);
>                 }
> +               state->valid |= ACL_USER_OBJ;
>                 break;
>         case ACL_USER:
>                 i = find_uid(state, ace->who_uid);
> @@ -655,6 +657,7 @@ static void process_one_v4_ace(struct posix_acl_state *state,
>                         deny_bits_array(state->users, mask);
>                         deny_bits_array(state->groups, mask);
>                 }
> +               state->valid |= ACL_GROUP_OBJ;
>                 break;
>         case ACL_GROUP:
>                 i = find_gid(state, ace->who_gid);
> @@ -686,6 +689,7 @@ static void process_one_v4_ace(struct posix_acl_state *state,
>                         deny_bits_array(state->users, mask);
>                         deny_bits_array(state->groups, mask);
>                 }
> +               state->valid |= ACL_OTHER;
>         }
>  }
>
> @@ -726,6 +730,28 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
>                 if (!(ace->flag & NFS4_ACE_INHERIT_ONLY_ACE))
>                         process_one_v4_ace(&effective_acl_state, ace);
>         }
> +
> +       /*
> +        * At this point, the default ACL may have zeroed-out entries for owner,
> +        * group and other. That usually results in a non-sensical resulting ACL
> +        * that denies all access except to any ACE that was explicitly added.
> +        *
> +        * The setfacl command solves a similar problem with this logic:
> +        *
> +        * "If  a  Default  ACL  entry is created, and the Default ACL contains
> +        *  no owner, owning group, or others entry,  a  copy of  the  ACL
> +        *  owner, owning group, or others entry is added to the Default ACL."
> +        *
> +        * If none of the requisite ACEs were set, and some explicit user or group
> +        * ACEs were, copy the requisite entries from the effective set.
> +        */
> +       if (!default_acl_state.valid &&
> +           (default_acl_state.users->n || default_acl_state.groups->n)) {
> +               default_acl_state.owner = effective_acl_state.owner;
> +               default_acl_state.group = effective_acl_state.group;
> +               default_acl_state.other = effective_acl_state.other;
> +       }
> +
>         *pacl = posix_state_to_acl(&effective_acl_state, flags);
>         if (IS_ERR(*pacl)) {
>                 ret = PTR_ERR(*pacl);
>
> ---
> base-commit: 9d985ab8ed33176c3c0380b7de589ea2ae51a48d
> change-id: 20230719-nfsd-acl-5ab61537e4e6
>
> Best regards,
> --
> Jeff Layton <jlayton@kernel.org>

Thanks,
Andreas
