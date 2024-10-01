Return-Path: <linux-fsdevel+bounces-30515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DED2198C126
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 17:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50C24B26923
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 15:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2443A1C9DF9;
	Tue,  1 Oct 2024 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZVHhMy8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2B21C9DF7
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795064; cv=none; b=MXAx9ev+z7swOSeR/D24fzHb6pCo4SYxD4zKB+hiBgnTOr3fxfFea8q6PQbKzR6DWuIinntuXK5n0DXhnYwAOBQRriLpRYHKPoGZ5yBpGcO4aGNsRfYgeeIqPYlCEj+76EgHKQ/i07dLsSj69vu5XLSLC6nYXFa044mALYQH1X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795064; c=relaxed/simple;
	bh=gF6r8WnrQH2b+Vt7tiA980NrtXF93+h0MtPYmhpJL0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beRwlybwpDX8D+yTr5qZ003T3EIdc1fJn0zIAZ155pfgypeUGKEotY9HYQ72xxIvZgpR9NqLXCsXg77b67idsVIyl8hpXfyZN32EZqNHUxFUb4sfZZ0BL2M0r/oC7MkRASnmqLKFQYMerBwTSj6nzsrFLa5JbK5oGS+Dl1zdAjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZVHhMy8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727795062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHLSGGnWvPoqO0ClIGivuffMh5vVjCKIDhDPct8AAM4=;
	b=XZVHhMy8aA8tVe+b2lQlYoVYA/d+HnldHXuMfRnKL3M52p2+Ca4ZCd4J5YNXKxyiyzxD5T
	8zweelvsu24CFhkRp1iTYkQ5Tz0hlNzh+Qg4oICx40HrMoDgPvz3RZoy6DbKVeqvKh4XSN
	Eyx4bgWLujQ1SVu0R+FI3CwYfmxzlzg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-MbWWXFUKPAeACwjOonTi1Q-1; Tue,
 01 Oct 2024 11:04:18 -0400
X-MC-Unique: MbWWXFUKPAeACwjOonTi1Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02C2F19776A1;
	Tue,  1 Oct 2024 15:04:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.88])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A366D1848B73;
	Tue,  1 Oct 2024 15:03:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  1 Oct 2024 17:03:07 +0200 (CEST)
Date: Tue, 1 Oct 2024 17:02:58 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: stsp <stsp2@yandex.ru>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Florent Revest <revest@chromium.org>, Kees Cook <kees@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Benjamin Gray <bgray@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Zev Weiss <zev@bewilderbeest.net>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-fsdevel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v3] add group restriction bitmap
Message-ID: <20241001150258.GD23907@redhat.com>
References: <20240930195958.389922-1-stsp2@yandex.ru>
 <20241001111516.GA23907@redhat.com>
 <02ae38f6-698c-496f-9e96-1376ef9f1332@yandex.ru>
 <20241001130236.GB23907@redhat.com>
 <62362149-c550-490f-bd7a-0fd7a5cd22bc@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62362149-c550-490f-bd7a-0fd7a5cd22bc@yandex.ru>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

We can't understand each other. I guess I missed something...

On 10/01, stsp wrote:
>
> 01.10.2024 16:02, Oleg Nesterov пишет:
> >On 10/01, stsp wrote:
> >>01.10.2024 14:15, Oleg Nesterov пишет:
> >>>Suppose we change groups_search()
> >>>
> >>>	--- a/kernel/groups.c
> >>>	+++ b/kernel/groups.c
> >>>	@@ -104,8 +104,11 @@ int groups_search(const struct group_info *group_info, kgid_t grp)
> >>>				left = mid + 1;
> >>>			else if (gid_lt(grp, group_info->gid[mid]))
> >>>				right = mid;
> >>>	-		else
> >>>	-			return 1;
> >>>	+		else {
> >>>	+			bool r = mid < BITS_PER_LONG &&
> >>>	+				 test_bit(mid, &group_info->restrict_bitmap);
> >>>	+			return r ? -1 : 1;
> >>>	+		}
> >>>		}
> >>>		return 0;
> >>>	 }
> >>>
> >>>so that it returns, say, -1 if the found grp is restricted.
> >>>
> >>>Then everything else can be greatly simplified, afaics...
> >>This will mean updating all callers
> >>of groups_search(), in_group_p(),
> >>in_egroup_p(), vfsxx_in_group_p()
> >Why? I think with this change you do not need to touch in_group_p/etc at all.
> >
> >>if in_group_p() returns -1 for not found
> >>and 0 for gid,
> >With the the change above in_group_p() returns 0 if not found, !0 otherwise.
> >It returns -1 if grp != cred->fsgid and the found grp is restricted.
>
> in_group_p() doesn't check if the
> group is restricted or not.

And it shouldn't. It returns the result of groups_search() if this
grp is supplementary or "not found".

> acl_permission_check() does, but
> in your example it doesn't as well.

But it does??? see below...

> I think you mean to move the
> restrict_bitmap check upwards to
> in_group_p()?

No, I meant to move the restrict_bitmap check to groups_search(), see the patch
above.

> Anyway, suppose you don't mean that.
> In this case:
> 1. in_group_p() and in_egroup_p()
>   should be changed:
> -  int retval = 1;
> + int retval = -1;

Why? -1 means that the grp is supplementary and restricted.

> There are also the callers of groups_search()
> in kernel/auditsc.c and they should
> be updated.

Why? I don't think so. audit_filter_rules() uses the result of groups_search()
as a boolean.

> >So acl_permission_check() can simply do
> >
> >	if (mask & (mode ^ (mode >> 3))) {
> >		vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
> >		int xxx = vfsgid_in_group_p(vfsgid);
> >
> >		if (xxx) {
> >			if (mask & ~(mode >> 3))
> >				return -EACCES;
> >			if (xxx > 0)
> >				return 0;
> >			/* If we hit restrict_bitmap, then check Others. */
> >		}
> >	}
>
> Well, in my impl it should check
> the bitmap right here, but you removed
> that.

No, I didn't remove the check, this code relies on the change in
groups_search(). Note the "xxx > 0" check.

I must have missed something :/

Oleg.


