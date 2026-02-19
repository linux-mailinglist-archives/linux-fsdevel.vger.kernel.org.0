Return-Path: <linux-fsdevel+bounces-77703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBwjM9UBl2k8tgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 13:28:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 298A615E96F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 13:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A45F302D5FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 12:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9E1308F26;
	Thu, 19 Feb 2026 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NuVIh1LF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="doShqaY8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5483A242D97
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771504077; cv=none; b=EN8Aqq+3UeP3hQdXGvQEXh1Fkinjofg8IIP5WvJiLDvr/2MKf1shmQL/90WwqjmTP18pALK8isgn3EZI6s2/55HmYM8B/0rxCLN4/zohC8clUZouW2U/iN4DmUCgJdm0eLLwfuAfFI9NrnQ/QJbGO0BejMsb3f3xNnbgiFpqZok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771504077; c=relaxed/simple;
	bh=EDx8FryHxIAZRwRNlicUl1+uu9x6LbeOBuYZocMQ30I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNoS9CGE+HzACaJaGSekGUpeyvWsdcOi/0glZOaFHswCKMMWBm1qNcbfAjyg4ePtmZnT8+dZW57y85p1EKlPpxJ5BDyVTsErV+LdpVVpLQW3c7ZYzI2Hw3KjmhrJldHJBohOQ5ZGdR0iNe72n9OzwF84UT7YusMWVvWsxdz0jgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NuVIh1LF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=doShqaY8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771504075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LCXhggTxc1o7a68agx3rWoCqxTRmf4Yj32SklYi3Ezs=;
	b=NuVIh1LF3INVOhDu7ub+SLf4HZk31F32gMpnLMO/1mMNU0mU9vX2YogcGuyzef4FS7nIta
	0wSumR2zgYdpQTj7sEMkwg2ueGCz7Lzweb1Ji6nB+huVYHYg4owcGJ37u/BKsOVVqYA5h3
	BG1ViygKF18/QV9fOFKPG3mLoJuvLnI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-Im2_LZIhMPm8DY_0ES537A-1; Thu, 19 Feb 2026 07:27:54 -0500
X-MC-Unique: Im2_LZIhMPm8DY_0ES537A-1
X-Mimecast-MFC-AGG-ID: Im2_LZIhMPm8DY_0ES537A_1771504073
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48071615686so7385145e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 04:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771504073; x=1772108873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LCXhggTxc1o7a68agx3rWoCqxTRmf4Yj32SklYi3Ezs=;
        b=doShqaY8X5G1zQ1Gbw7oiKlp7sVhboZsHKJyz1XI6nKF3gQSpUFkCTyRFwUx7Ncnnj
         Lxe0dqd8AiqQImVio0LuS6JJoeoP66l7hxhd6eoS2l6FHN594SZvNvUkEWI3KNLJHS90
         e3rwiR2VhRwo4kEn0YQ4wg6pCW2xnHD4LdZIqn9mPFmCwksAm+2D3R16fHk7iI+fdKpM
         TweOowdc+81oM4QckO1ejdByYKv5QkRB2T9FRcJwN/PkVFpXIPX0MefCih3c+VcNEJJu
         dj/ROZFMdD0FZzA1zUok3Uh/1weXqJ4F5+6Ud/9Mr/AQYoXTV7oyfIWqrWyJYHnXeYGh
         y1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771504073; x=1772108873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCXhggTxc1o7a68agx3rWoCqxTRmf4Yj32SklYi3Ezs=;
        b=WTHO4/NiIuFffwr14mV+lmt8BMlqX5127cPntLyVC8ku33KVDlFwZYgeulWuB4EtR4
         jHGnRnOGiOFEtwWLpx9BQ5UgvuMz44PQh2IMgez4Zld9m00kAnnqCR3yRfGW+zEv07jV
         7XHOGp8DUozrATZ6kVbDKbxUo8RmdQNcL5qUmDKl8a6ACdj21YFxD0exV7jTar83Vb19
         +xhjQPdyXKZDTg4fmaqjyXenBCNvP3lzs+9xVFuexba6N8q+ipgkA0/PCvwytVBXJpvD
         ywdqDZdV5RTTv6WkkbfeJD18LvSMPtVhwAtm3TnxtAQxxnjfeFr/zYT0fuaKZ5YgX+hs
         tS/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9XxUBBjgs4E9Sitce0DvHzZDgdA9MM8G7Fzxkwip6L5Ow2cJVuHYAz2mB132J/iBI8yCdudbosbc6fQry@vger.kernel.org
X-Gm-Message-State: AOJu0YzJJZ9KrmrwLIzCX6GC3NdGiHiUDBB0KCQGa6JtnZWpu7I2YWhU
	m5tvvxqVGkqWQzfjhHRlF42JG7Devdp8iHHleef8zwQf483VGkrpEcxnRiV6L7U6Uhfqlblb4li
	tqbo67MNOJnP8qJwNiKAuSd+SqLJQKPNcCU0pWjUi0V31Ska6GBXENzwj0Ylq8YxGYQ==
X-Gm-Gg: AZuq6aKzLd4EnVKxSvo2hM3tu/OSjJCmLBFqfpqwiICvjDKhlMIG/mLGZGKVck6zX5t
	w8EmERGqIh00QAdvwBBCvYTUurjmbzwoorW15HAcaW/Djgsq9IkCBvMzvf0HpMxnqCc0jbYSsMz
	pxDOi7daj8cObqMwTweE1KzZ8AXtI9MazWVqIcsMtrSeMh/OuqQR7yG7BIZwqok5ZE6mci8pZAF
	wjlBFH+qjl7Qd/o24bx7u9p5Tf6iP7IPD6WA0zqPdMRewLgGZNnG3O9R7G351YnXDGpbs4YNZVh
	0a+ABJEZ59OBZQK7l0IQdObvj1g9a2cSKdskJLcH9GvM95KXpdzx+CSDZh+eq0wWOndPQkiZYC1
	DIaaMqSmQmfs=
X-Received: by 2002:a05:600c:3f0e:b0:47a:7fd0:9eea with SMTP id 5b1f17b1804b1-48398a42840mr90767065e9.3.1771504072831;
        Thu, 19 Feb 2026 04:27:52 -0800 (PST)
X-Received: by 2002:a05:600c:3f0e:b0:47a:7fd0:9eea with SMTP id 5b1f17b1804b1-48398a42840mr90766495e9.3.1771504072258;
        Thu, 19 Feb 2026 04:27:52 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839f985e4asm17268675e9.20.2026.02.19.04.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 04:27:51 -0800 (PST)
Date: Thu, 19 Feb 2026 13:27:51 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de
Subject: Re: [PATCH v3 08/35] iomap: don't limit fsverity metadata by EOF in
 writeback
Message-ID: <oecxvzv56qk5qnlf2e4dwaaeyeyvpautlqfqnozurplikewopw@q7y6toosmyed>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-9-aalbersh@kernel.org>
 <20260218230504.GG6467@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218230504.GG6467@frogsfrogsfrogs>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77703-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 298A615E96F
X-Rspamd-Action: no action

On 2026-02-18 15:05:04, Darrick J. Wong wrote:
> On Wed, Feb 18, 2026 at 12:19:08AM +0100, Andrey Albershteyn wrote:
> > fsverity metadata is stored at the next folio after largest folio
> > containing EOF.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> 
> I think this should be in the previous patch since writeback is part of
> pagecache writes.

ok, sure

> 
> Also, should there be a (debug) check somewhere that an IOMAP_F_FSVERITY
> mapping gets mapped to a folio that's entirely above EOF?

I rewrote it as below and added 
	WARN_ON_ONCE(folio_pos(folio) < isize)

-- 
- Andrey

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4cf9d0991dc1..ef9a5f542354 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1746,13 +1746,21 @@ static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
  * Check interaction of the folio with the file end.
  *
  * If the folio is entirely beyond i_size, return false.  If it straddles
- * i_size, adjust end_pos and zero all data beyond i_size.
+ * i_size, adjust end_pos and zero all data beyond i_size. Don't skip fsverity
+ * folios as those are beyond i_size.
  */
-static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
-               u64 *end_pos)
+static bool iomap_writeback_handle_eof(struct folio *folio,
+                                      struct iomap_writepage_ctx *wpc,
+                                      u64 *end_pos)
 {
+       struct inode *inode = wpc->inode;
        u64 isize = i_size_read(inode);
 
+       if (wpc->iomap.flags & IOMAP_F_FSVERITY) {
+               WARN_ON_ONCE(folio_pos(folio) < isize);
+               return true;
+       }
+
        if (*end_pos > isize) {
                size_t poff = offset_in_folio(folio, isize);
                pgoff_t end_index = isize >> PAGE_SHIFT;
@@ -1817,7 +1825,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 
        trace_iomap_writeback_folio(inode, pos, folio_size(folio));
 
-       if (!iomap_writeback_handle_eof(folio, inode, &end_pos))
+       if (!iomap_writeback_handle_eof(folio, wpc, &end_pos))
                return 0;
        WARN_ON_ONCE(end_pos <= pos);


