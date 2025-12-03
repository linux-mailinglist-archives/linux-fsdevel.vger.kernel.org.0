Return-Path: <linux-fsdevel+bounces-70564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA67C9F8B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 16:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 378A5300A6EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 15:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157A82DA769;
	Wed,  3 Dec 2025 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACDBrCvr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F364311C15
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776142; cv=none; b=i34tr9JXHWvhxOEyh/5QgkzIi3rV/aPh95I1i8qJWIvztA4/dW8BOXpDwUsgfIM7fLaVYR55vYICUVsp8p3f+McYyrUKC/6HsTmrQdKdfDU6uZXieZA6k62fYzpnKAgRV8zpHXgmYzs7gfJ35/jsdj8VspCYzjTj9LJ+SvqilNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776142; c=relaxed/simple;
	bh=w4A2UegXwtOrwBEh5yC+6bOraNmFEGQzXJlFijVxv7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XeNC4nDPUe9P1xGtKfORWTez6EHtJsD/WjuFJ740zn5vZ60ow4qipLbyWCXWj5YYrUQ6q4AAmQJUSUiHKU4IQPy/dOKNE3G5qzBaDFsYWukJaFI9y5s4POJ4yh6NJWe3Milaz/AjlwRpSgX+mADsAJa9uqNHMGvaw9HDW0xehLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACDBrCvr; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3438231df5fso8056114a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 07:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764776140; x=1765380940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGbO2/2t1gFhYYme3zOuFfWPsTzKJnXlmoRT6R7R7HQ=;
        b=ACDBrCvrdOub/paqt3Lhc2vov+K9R1lUYZN3tqC+Cdw668Opp/8Xzdxo2QRO9Tlhaj
         JPbsmmXEfOrWuasIoR/U+/gsXqMLRoRzdY7McjkeQlrsPlKCQ+hQBf5Ip4ILCMY3qk9C
         AB6Sjf55UZcC6TAVZtm/ZJqEVEhoY6nmICfaULXsEjePQTDAB0x8qQFVsaOpPomnI70r
         iS0TPerUKqu+URC1Jr+CUVSzavw8T3oNR6ULLWO2bfED9m/LlqRRvUtAVMrpuRyYjW9U
         d7uhzgOYVn7YfKGtvjwwW5aoAilGZ9exAg5suTjdapATv700dADSP3d1rqGWJXZdIUq2
         rKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764776140; x=1765380940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QGbO2/2t1gFhYYme3zOuFfWPsTzKJnXlmoRT6R7R7HQ=;
        b=dEDmaIfBQs08Af06XpxYhgcNt8WvU35C7uIuAJ3hZPFY7B+XsaFwZ6eqLHyIGDkDhn
         IuRpstxx0O+0/DdJhrE2xKYZgpO3H0Q1eLS2rRjgANqqEWWnyMUXhW3qq8Dgo05rr+zt
         YHYeGthiM/mVZo+0GBoViUKBAfUCXLi8+8lCVrOjchazhXhSfZPlrKiRfaLPoHnXtjA1
         3AGgILCDs9BiLNCSvor+mL9oZK9CiydU9kPzwAg52QFqtIelTiZCIZ1J+rqDK8H5s1vY
         RmEmmLM/yloke02aeIbNg7/rdtcfTSL9nsP4uZPCyw1eKC0b89MzJ02qrMOWQNStnWfb
         RfQA==
X-Forwarded-Encrypted: i=1; AJvYcCUfPaQ+JRW3BGNKUeDxJXGurvmurPQhW/PKl2Vzd7zz61v25gr0DsiBKSXidxIsxBs1xes6ggHPHHElN3AH@vger.kernel.org
X-Gm-Message-State: AOJu0YzLgs8cQN0CX26cnLBNyjqyynISrWriPeyF0KhwtZJt7tQsyoWE
	uQdFzEQ41i2aiPFq4eUOdaa8POJKu9HlAAGqx//qF3vgPSqMi93tiH4vM6nOMBScliBaMltmX8m
	1Qx9ITDUiKhfj0owUddV3IIbiO3x2kqs=
X-Gm-Gg: ASbGncuWIr+CytvwyOkhV4/DqtLZnEHjzAE6y+KgKp+7OH5zImZGxROq5R7tg01XWLX
	qtZtYPlRDb5WId2CtYYmw6gn+NhpwgfFwcf+0dceWKO7mOAFdJfnNUzDgutAf8lMFVMvxO5qSsW
	X1z2OL59NdzKp86JCgmB4l6wfxVZkl143BJq4TiFss4H/5adfMVLcT8wNWPsQljsUZ5MBuBU9Je
	33xdz/nY63mgswse3O+X7lVtwILd0gwMy4p/NFgtBlRzuMk3H30jRXluiEQ3tHVhYoqzVk=
X-Google-Smtp-Source: AGHT+IEn9vxknosINeRwqaUkMbRpVbYZ9rAaqqFNWjUkmEIFHUcEtIIP4pCogGv3nNhRP3bv8J9Bo8pWrUn/qzHHVX0=
X-Received: by 2002:a17:90b:1c09:b0:336:9dcf:ed14 with SMTP id
 98e67ed59e1d1-349127f9576mr3362218a91.23.1764776139904; Wed, 03 Dec 2025
 07:35:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com>
 <CAHC9VhQyDX+NgWipgm5DGMewfVTBe3DkLbe_AANRiuAj40bA1w@mail.gmail.com>
 <6797b694-6c40-4806-9541-05ce6a0b07fc@oracle.com> <CAHC9VhQsK_XpJ-bbt6AXM4fk30huhrPvvMSEuHHTPb=eJZwoUA@mail.gmail.com>
 <CAHC9VhQnR6TKzzzpE9XQqiFivV0ECbVx7GH+1fQmz917-MAhsw@mail.gmail.com>
In-Reply-To: <CAHC9VhQnR6TKzzzpE9XQqiFivV0ECbVx7GH+1fQmz917-MAhsw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 3 Dec 2025 10:35:28 -0500
X-Gm-Features: AWmQ_bkzJ94ne_NaS9DdGj-0rfpzDplsxIIA51owmAroNoWGHAQbs9nJIizmk5w
Message-ID: <CAEjxPJ7_7_Uru3dwXzNLSj5GdBTzdPDQr5RwXtdjvDv9GjmVAQ@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Paul Moore <paul@paul-moore.com>
Cc: Anna Schumaker <anna.schumaker@oracle.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 10:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Thu, Jun 19, 2025 at 5:18=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, May 27, 2025 at 5:03=E2=80=AFPM Anna Schumaker
> > <anna.schumaker@oracle.com> wrote:
> > > On 5/20/25 5:31 PM, Paul Moore wrote:
> > > > On Tue, Apr 29, 2025 at 7:34=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > >> On Mon, Apr 28, 2025 at 4:15=E2=80=AFPM Stephen Smalley
> > > >> <stephen.smalley.work@gmail.com> wrote:
> > > >>>
> > > >>> Update the security_inode_listsecurity() interface to allow
> > > >>> use of the xattr_list_one() helper and update the hook
> > > >>> implementations.
> > > >>>
> > > >>> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-steph=
en.smalley.work@gmail.com/
> > > >>>
> > > >>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > >>> ---
> > > >>> This patch is relative to the one linked above, which in theory i=
s on
> > > >>> vfs.fixes but doesn't appear to have been pushed when I looked.
> > > >>>
> > > >>>  fs/nfs/nfs4proc.c             | 10 ++++++----
> > > >>>  fs/xattr.c                    | 19 +++++++------------
> > > >>>  include/linux/lsm_hook_defs.h |  4 ++--
> > > >>>  include/linux/security.h      |  5 +++--
> > > >>>  net/socket.c                  | 17 +++++++----------
> > > >>>  security/security.c           | 16 ++++++++--------
> > > >>>  security/selinux/hooks.c      | 10 +++-------
> > > >>>  security/smack/smack_lsm.c    | 13 ++++---------
> > > >>>  8 files changed, 40 insertions(+), 54 deletions(-)
> > > >>
> > > >> Thanks Stephen.  Once we get ACKs from the NFS, netdev, and Smack
> > > >> folks I can pull this into the LSM tree.
> > > >
> > > > Gentle ping for Trond, Anna, Jakub, and Casey ... can I get some AC=
Ks
> > > > on this patch?  It's a little late for the upcoming merge window, b=
ut
> > > > I'd like to merge this via the LSM tree after the merge window clos=
es.
> > >
> > > For the NFS change:
> > >     Acked-by: Anna Schumaker <anna.schumaker@oracle.com>
> >
> > Hi Anna,
> >
> > Thanks for reviewing the patch.  Unfortunately when merging the patch
> > today and fixing up some merge conflicts I bumped into an odd case in
> > the NFS space and I wanted to check with you on how you would like to
> > resolve it.
> >
> > Commit 243fea134633 ("NFSv4.2: fix listxattr to return selinux
> > security label")[1] adds a direct call to
> > security_inode_listsecurity() in nfs4_listxattr(), despite the
> > existing nfs4_listxattr_nfs4_label() call which calls into the same
> > LSM hook, although that call is conditional on the server supporting
> > NFS_CAP_SECURITY_LABEL.  Based on a quick search, it appears the only
> > caller for nfs4_listxattr_nfs4_label() is nfs4_listxattr() so I'm
> > wondering if there isn't some room for improvement here.
> >
> > I think there are two obvious options, and I'm curious about your
> > thoughts on which of these you would prefer, or if there is another
> > third option that you would like to see merged.
> >
> > Option #1:
> > Essentially back out commit 243fea134633, removing the direct LSM call
> > in nfs4_listxattr() and relying on the nfs4_listxattr_nfs4_label() for
> > the LSM/SELinux xattrs.  I think we would want to remove the
> > NFS_CAP_SECURITY_LABEL check and build nfs4_listxattr_nfs4_label()
> > regardless of CONFIG_NFS_V4_SECURITY_LABEL.
> >
> > Option #2:
> > Remove nfs4_listxattr_nfs4_label() entirely and keep the direct LSM
> > call in nfs4_listxattr(), with the required changes for this patch.
> >
> > Thoughts?
> >
> > [1] https://lore.kernel.org/all/20250425180921.86702-1-okorniev@redhat.=
com/
>
> A gentle ping on the question above for the NFS folks.  If I don't
> hear anything I'll hack up something and send it out for review, but I
> thought it would nice if we could sort out the proper fix first.

Raising this thread back up again to see if the NFS folks have a
preference on option #1 or #2 above, or
something else altogether. Should returning of the security.selinux
xattr name from listxattr() be dependent on
NFS_CAP_SECURITY_LABEL being set by the server and should it be
dependent on CONFIG_NFS_V4_SECURITY_LABEL?

