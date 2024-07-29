Return-Path: <linux-fsdevel+bounces-24449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF5393F6F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 15:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96642281E9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 13:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9705814EC4E;
	Mon, 29 Jul 2024 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDpaYfrH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8F4147C86;
	Mon, 29 Jul 2024 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260780; cv=none; b=Sl6o0UKzr8OoBEfZwaefjFBZvd4SArjbUMiuTXzVYbkZLg4xmH83afeiNwD/XdsHdINxmqZZdNB1T1hHSGbaFFJhl8yGlrTs6F1GPjqaRh2KTrV7C5g4EPnjYGE9NQ0Z42MpIrrdCiP5uGzQ7z0cM9Wvb6xPYu16GoX7i1JVF2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260780; c=relaxed/simple;
	bh=O3MU1F+c8ywd1xSZMUCNs8kMjtY9ytEAMnzRHa8ilj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+IgT5Z6wd0MarjiOhPbjj2wWhWHdPTCTuQIZvxwU6+ZeVYlgJAyPxQxRrPrUcJz+xICUAfgCaDW3F/uqOD6t3P5/o3dqW50P6VTwes7OCAw4OYXM+9TIs+g+m5ETQA328nrKzI4nuz5dT2/f8N7cvNXPH5gPX2TrJ00hhyBVaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDpaYfrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5366C32786;
	Mon, 29 Jul 2024 13:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722260779;
	bh=O3MU1F+c8ywd1xSZMUCNs8kMjtY9ytEAMnzRHa8ilj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WDpaYfrHVrMbDf5qh9q5I3HDuYGxJoKS14RrlGHfCv3BfWbNTZbcgiBE5dsWTnolB
	 rINh7jqMVBb/Vw1/pGcnbuP0QOXWuzrVxh/7n7f8Ntgyi3jKRib1zLKO8rOEWXXlUZ
	 3Kd1L3yo/GDb6QehxssSFXf6RLmhZTcFFkUD7HR4zY9p4AZ2oSjWNW3r8a+wZEE6zF
	 TL45jq6z5MGmT68Zb13ha2TamUw1RAU425cSn8WQFgp8AFSXTUePqesgdHO+XicRN8
	 rr0OB9Yy0vTHPAbA7rfwwtWtNnJKWXky1pzdFui4zGnLrAFkWzdNKE6x56MNziBOjz
	 lmhUdyoJ+HRHg==
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <songliubraving@meta.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Song Liu <song@kernel.org>,
	bpf <bpf@vger.kernel.org>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jack@suse.cz" <jack@suse.cz>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>,
	"mattbobrowski@google.com" <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for bpf_get_dentry_xattr
Date: Mon, 29 Jul 2024 15:46:06 +0200
Message-ID: <20240729-zollfrei-verteidigen-cf359eb36601@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CDDCB34B-4B01-40CA-B512-33023529D104@fb.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3699; i=brauner@kernel.org; h=from:subject:message-id; bh=O3MU1F+c8ywd1xSZMUCNs8kMjtY9ytEAMnzRHa8ilj4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQtn6sY/nTdvc/6HNs2h2x7rVZY4FEio+x0bXJV0QUfk /0vTrx27ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI7QtGhgNbDj3/e2RXhvU8 69UBa0P/NPk/rnqavH7WyX75NDaz5w4M/zSuL//OJbJ958aD0Vzruj/ua8s1/yKwiCHe4mer79I lKxgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Jul 26, 2024 at 07:43:28PM GMT, Song Liu wrote:
> Hi Christian, 
> 
> Thanks a lot for your comments.
> 
> > On Jul 26, 2024, at 4:51 AM, Christian Brauner <brauner@kernel.org> wrote:
> > 
> > On Fri, Jul 26, 2024 at 09:19:54AM GMT, Song Liu wrote:
> >> Hi Christian, 
> >> 
> >>> On Jul 26, 2024, at 12:06 AM, Christian Brauner <brauner@kernel.org> wrote:
> >> 
> >> [...]
> >> 
> >>>> +
> >>>> + for (i = 0; i < 10; i++) {
> >>>> + ret = bpf_get_dentry_xattr(dentry, "user.kfunc", &value_ptr);
> >>>> + if (ret == sizeof(expected_value) &&
> >>>> +    !bpf_strncmp(value, ret, expected_value))
> >>>> + matches++;
> >>>> +
> >>>> + prev_dentry = dentry;
> >>>> + dentry = bpf_dget_parent(prev_dentry);
> >>> 
> >>> Why do you need to walk upwards and instead of reading the xattr values
> >>> during security_inode_permission()?
> >> 
> >> In this use case, we would like to add xattr to the directory to cover
> >> all files under it. For example, assume we have the following xattrs:
> >> 
> >>  /bin  xattr: user.policy_A = value_A
> >>  /bin/gcc-6.9/ xattr: user.policy_A = value_B
> >>  /bin/gcc-6.9/gcc xattr: user.policy_A = value_C
> >> 
> >> /bin/gcc-6.9/gcc will use value_C;
> >> /bin/gcc-6.9/<other_files> will use value_B;
> >> /bin/<other_folder_or_file> will use value_A;
> >> 
> >> By walking upwards from security_file_open(), we can finish the logic 
> >> in a single LSM hook:
> >> 
> >>    repeat:
> >>        if (dentry have user.policy_A) {
> >>            /* make decision based on value */;
> >>        } else {
> >>            dentry = bpf_dget_parent();
> >>            goto repeat;
> >>        }
> >> 
> >> Does this make sense? Or maybe I misunderstood the suggestion?
> > 
> > Imho, what you're doing belongs into inode_permission() not into
> > security_file_open(). That's already too late and it's somewhat clear
> > from the example you're using that you're essentially doing permission
> > checking during path lookup.
> 
> I am not sure I follow the suggestion to implement this with 
> security_inode_permission()? Could you please share more details about
> this idea?

Given a path like /bin/gcc-6.9/gcc what that code currently does is:

* walk down to /bin/gcc-6.9/gcc
* walk up from /bin/gcc-6.9/gcc and then checking xattr labels for:
  gcc
  gcc-6.9/
  bin/
  /

That's broken because someone could've done
mv /bin/gcc-6.9/gcc /attack/ and when this walks back and it checks xattrs on
/attack even though the path lookup was for /bin/gcc-6.9. IOW, the
security_file_open() checks have nothing to do with the permission checks that
were done during path lookup.

Why isn't that logic:

* walk down to /bin/gcc-6.9/gcc and check for each component:

  security_inode_permission(/)
  security_inode_permission(gcc-6.9/)
  security_inode_permission(bin/)
  security_inode_permission(gcc)
  security_file_open(gcc)

I think that dget_parent() logic also wouldn't make sense for relative path
lookups:

	dfd = open("/bin/gcc-6.9", O_RDONLY | O_DIRECTORY | O_CLOEXEC);

This walks down to /bin/gcc-6.9 and then walks back up (subject to the
same problem mentioned earlier) and check xattrs for:

  gcc-6.9
  bin/
  /

then that dfd is passed to openat() to open "gcc":

fd = openat(dfd, "gcc", O_RDONLY);

which again walks up to /bin/gcc-6.9 and checks xattrs for:
  gcc
  gcc-6.9
  bin/
  /

Which means this code ends up charging relative lookups twice. Even if one
irons that out in the program this encourages really bad patterns.
Path lookup is iterative top down. One can't just randomly walk back up and
assume that's equivalent.

