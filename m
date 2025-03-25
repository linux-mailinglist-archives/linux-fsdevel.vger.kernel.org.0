Return-Path: <linux-fsdevel+bounces-44938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B0BA6ED53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 11:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5DC16E76C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 10:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3261F9A95;
	Tue, 25 Mar 2025 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8Ux/VdZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E8A1A2389
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742897423; cv=none; b=BbyxG4LiYaJWnpLdK6KN1/+wse6CTDiszr7bllfqPoMOKIYw25tD48UTzaD/VkpSPjjrJSovNYuvpbVeIj49pyGwbpFeUpprobA3JZrcmOdenJSghrujlBP0lnEuE3mVscCrE2/s4rd8Fv8MfI3c4aRI5ONr6etNN1mZhrYRjuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742897423; c=relaxed/simple;
	bh=+yHwlyVryiDRjhu9Lrq1vGrFAuzbF6NTK9Kgojwnnyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbLFeCSYFlDcjWPTyxYxM+k3/F33iX0/9lmUQvfbsCI0GbhWuz4IfjF3neKEjILdztnrAJoLiOJuNhVYCNNZDwVOs2odZkoyB69bcJvcC7EMmkfQmgzbBKvGW+WKXp6Z0W4j4Dfx2VhgpWbuXNi4a4yVG5gAQMQw9EuNBUKwmm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8Ux/VdZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742897420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+yHwlyVryiDRjhu9Lrq1vGrFAuzbF6NTK9Kgojwnnyo=;
	b=e8Ux/VdZ8/0rqameauoBQanfYKTZa/3JGDtmlDzV/fvSXiG8wVJPOOjNbOYdZA8PARBP02
	45PPtwR/FEjo+FFyaos8IQ0zpEZY3wzbt7X67bHXBm4ReEMWZjYzod9rR9tY4Nl9OltmPm
	usZObD9xEdnlbk+V3SK9OFuggttb2DM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-liIXkxccNoKKRN5ZT6cOSw-1; Tue,
 25 Mar 2025 06:10:17 -0400
X-MC-Unique: liIXkxccNoKKRN5ZT6cOSw-1
X-Mimecast-MFC-AGG-ID: liIXkxccNoKKRN5ZT6cOSw_1742897415
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C8D61801A06;
	Tue, 25 Mar 2025 10:10:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4080D1956095;
	Tue, 25 Mar 2025 10:10:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Mar 2025 11:09:42 +0100 (CET)
Date: Tue, 25 Mar 2025 11:09:37 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>,
	brauner@kernel.org, kees@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] exec: fix the racy usage of fs_struct->in_exec
Message-ID: <20250325100936.GC29185@redhat.com>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <20250324160003.GA8878@redhat.com>
 <CAGudoHHuZEc4AbxXUyBQ3n28+fzF9VPjMv8W=gmmbu+Yx5ixkg@mail.gmail.com>
 <20250324182722.GA29185@redhat.com>
 <CAGudoHE8AKKxvtw+e4KpOV5DuVcVdtTwO0XjaYSaFir+09gWhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHE8AKKxvtw+e4KpOV5DuVcVdtTwO0XjaYSaFir+09gWhQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 03/24, Mateusz Guzik wrote:
>
> On Mon, Mar 24, 2025 at 7:28 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > So to me it would be better to have the trivial fix for stable,
> > exactly because it is trivially backportable. Then cleanup/simplify
> > this logic on top of it.
>
> So I got myself a crap testcase with a CLONE_FS'ed task which can
> execve and sanity-checked that suid is indeed not honored as expected.

So you mean my patch can't fix the problem?

> Anyhow, the plan would be to serialize on the bit, synchronized with
> the current spin lock. copy_fs would call a helper to wait for it to
> clear, would still bump ->users under the spin lock.
>
> This would decouple the handling from cred_mutex and avoid weirdness
> like clearing the ->in_exec flag when we never set it.

I don't really understand the idea, but as I said I won't argue with
another solution.

Oleg.


