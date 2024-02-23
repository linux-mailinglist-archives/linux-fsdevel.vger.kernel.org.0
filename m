Return-Path: <linux-fsdevel+bounces-12586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0B48615C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 16:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273CA1C234F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 15:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28648286E;
	Fri, 23 Feb 2024 15:27:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC0B6E618;
	Fri, 23 Feb 2024 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702045; cv=none; b=gMR/XtDnMKuUsfHACHfwW0gm8Gv1nKumcQcBmQ8uRlinoyCS9xTf/tCOUR40MyVt1Zv6oTeptTARoS/xcIIemE/0nfpHM0JSlXVjERYTtVxCsi7rMDslInh1VRnw6D9G2SM4hwq0M3thAGFeQ3pZT6L/bOMdq+uhzGaq+S/wJG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702045; c=relaxed/simple;
	bh=qhYHyHTtGNXQyLwz6WLctgJcV/a1/yFXRXeviXKuHEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V56RJgAultmPHH7ri8u86VMz0W6Hd1qy6o9/t+EL3SSYETaqdUslodcJVlToY8+KDytKlqIIheS5yIwshYR+2yNbTS1/ml1SaOyLA7IR3QlJC5KGhVwjoPDMgUjJei0BS8xXbY+Xehtjeel2++yU1DzAUw4KMWoiEEuwTcEn82w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 41NFQieM066165;
	Sat, 24 Feb 2024 00:26:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Sat, 24 Feb 2024 00:26:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 41NFQhOx066161
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 24 Feb 2024 00:26:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <564df866-e874-400e-aff3-54d75295187b@I-love.SAKURA.ne.jp>
Date: Sat, 24 Feb 2024 00:26:41 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/17] mm: Add folio_end_read()
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
        npiggin@gmail.com
References: <20231004165317.1061855-1-willy@infradead.org>
 <20231004165317.1061855-4-willy@infradead.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20231004165317.1061855-4-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

During a bisection of a different problem, I noticed that
commit 0b237047d5a7 ("mm: add folio_end_read()") added folio_end_read() as

----------------------------------------
+void folio_end_read(struct folio *folio, bool success)
+{
+       if (likely(success))
+               folio_mark_uptodate(folio);
+       folio_unlock(folio);
+}
----------------------------------------

but commit f8174a118122 ("ext4: use folio_end_read()") for unknown reason
removed folio_clear_uptodate() call when bio->bi_status != 0.

----------------------------------------
-       bio_for_each_folio_all(fi, bio) {
-               struct folio *folio = fi.folio;
-
-               if (bio->bi_status)
-                       folio_clear_uptodate(folio);
-               else
-                       folio_mark_uptodate(folio);
-               folio_unlock(folio);
-       }
+       bio_for_each_folio_all(fi, bio)
+               folio_end_read(fi.folio, bio->bi_status == 0);
----------------------------------------

Why

	else
		folio_clear_uptodate(folio);

part is missing in folio_end_read() ?


