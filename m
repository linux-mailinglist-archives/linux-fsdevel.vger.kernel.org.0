Return-Path: <linux-fsdevel+bounces-68562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 909C6C6028B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 10:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 866534E4B3A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 09:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785FF274B2E;
	Sat, 15 Nov 2025 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Irl1Db9s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A62749E6
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763199784; cv=none; b=CiUkLhxHxPnhR0Pr/TPcjLIVcvPPFDf37VJmNhQFCttWLtjWUmdxDqVE8thjeggOySg93YwCH6+i7/8ejQtdWpJpeWqOQvD8GngmzknYqnOuZQngT5P0p0DRi1MgXo0Q96JwYK9nVJ7wYc+XIPlyB9Ojj6TvnJ6MTuMafq4YnKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763199784; c=relaxed/simple;
	bh=DXSySIzAxH5YmMIDou5gzx2YUuieC3V3X6LeZTrIkxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBAYPr2PDfQOSEAWl/zl4kPwJzO+0GHvMv2xj+uHHlaOHz7RcGrEpxKj9VxZ1L3RLsQaFaaEsDwngn3sGoF2VenKEGplBJdlR2EjDMtfE/NJvN0ffyTqC/lQ+kEQA68VXOWSWGYB4rUXnPGy7HLXmktWfaag9OP/YArqXpHrZDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Irl1Db9s; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so4885508a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 01:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763199781; x=1763804581; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bu/YvVGS6f/qPnY5owZrNEIEYGYSg1/BJENMGejEMt0=;
        b=Irl1Db9ssBDiuJZ4zBc0NLnYmiq8uabfziKe1n/FhYdy/+4U5nzDIMpOchP+/i1o/s
         aHZ+lB0RFuXmVAyZaiIssvveLar/B4I8jCh2z/6TKwR7j0vklP8A5f05vUZ7XLibL1iH
         QyNW3GBhr8txp6Q7qf6n65Wa9VA7RIBKnS0hyjzHxFep2Xm7jDqw3LRkNgijjMa3blMi
         X64kFrcN71BvGiCGU5cUwVBEt6D/CwTYvXk6o0jsKFjGKU5tw8joe5U0K7wPYxzTM6IK
         kN5ed/LGLAtmBrssWMwVMZ87oO79ZzpU0ACt2UTr3CAAKO6m/gYgSBfj92xHX04pB/KM
         lT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763199781; x=1763804581;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bu/YvVGS6f/qPnY5owZrNEIEYGYSg1/BJENMGejEMt0=;
        b=ER8khbA1qxl0FP6i5WBi7ft4r0+e29lEXJO1a8pT05/c9CJyGL60QnjYuswQ1CM97G
         woLekQQLKdRxlNF/YUgrsAAcRHE9NbJ+J3O5hRibrJKwgZ1YYVQzj/e/+a0VvQbO/LsG
         RxckXK56vWVf55VXNcG0PcEo7P4aJh6MWce/OEctWqKeQ2dJ8NZFS3arLU2GJtV4xiT8
         Yx4O5ucEjtGNI8DB6m8FEsqTo+gAU86kisSlY9O4kz/C0SFNT22vpNLPato7jM3KT7lB
         2wCoBjjDLolswyZndSw6Dp/UMJbszjiimO8o0AzNdA5SJqaSEEb4ekTrGlh1HhfMJGnf
         ThEA==
X-Forwarded-Encrypted: i=1; AJvYcCWqW7vsKt5mwwK2e9SyJpEcBIN3/y8CZD/81JgZFzuw239U4Q4QnYS4sm+kDpcZWSd2Y78sRmXVyz31apdJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwAm+3InWQ6nT7Vtft0+u+LN1v+Sc1vraZ+JAV0Av3oJr7+bGjv
	wdwVIFlS0rGU8P4Bp+qJPm/QjMHcYjxzGjeyDf//KZlF1ik7jXeboqP8
X-Gm-Gg: ASbGncvbaiQq/lK9a6964N5LdKh/EvSbUlTVd34XA/LRAM+UIXsOYV/w4HGF7iN9i+w
	p8Ocbj/LxXJIfrz9+r+01JaO5rRXBIvu6Ezy3yERO3+C7v4CDB+RWDqC86Z1w8lL4knp7/zRjLh
	PaS+3dW3wpNcxETzRZF1/RyJmcy9fRbCML0BjvJNk7RgNoly3PvHZdn+pSLrT8xXWXhmG3OX5vp
	kKyQUPunyEd5W7JYGqZJYti2F5EfMqc47hp3mZlte1ZUVNINK/SAna9i89cn3ppoP95qU/8l5b5
	83OMcw651OzWrkdiRz5wPwcEL0B3Vifg4QRaAOoZ7UGbqKliFTbcF8XxAJhFbNh9tBSyu1kdfsp
	EBFvDrMP76XZSHizaxSn1J7mJrEGMxDCL4Zn7ObXcsuM+75XLxk4YDTS1FsCOI0CEu368kd4ERY
	Vfj15z/Ci55Oa3ag==
X-Google-Smtp-Source: AGHT+IFHioosJ5jTazsiziwouzPq3smTtQsChFlOL19ZuV0U6amI73JZiw1PCFxxEy+MouamqQ1NYQ==
X-Received: by 2002:a17:907:7f09:b0:b3c:193:820e with SMTP id a640c23a62f3a-b736789d3dcmr582744066b.13.1763199781290;
        Sat, 15 Nov 2025 01:43:01 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad48dcsm575104566b.25.2025.11.15.01.43.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Nov 2025 01:43:00 -0800 (PST)
Date: Sat, 15 Nov 2025 09:43:00 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/huge_memory: consolidate order-related checks into
 folio_split_supported()
Message-ID: <20251115094300.rgdhse2v73xoivq5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251114075703.10434-1-richard.weiyang@gmail.com>
 <827fd8d8-c327-4867-9693-ec06cded55a9@kernel.org>
 <20251114150310.eua55tcgxl4mgdnp@master>
 <64b43302-e8cc-4259-9fa1-e27721c0d193@kernel.org>
 <20251115025109.yerb7gbty4h7h63s@master>
 <aRgKoQT2ZYH_x2wa@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRgKoQT2ZYH_x2wa@casper.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sat, Nov 15, 2025 at 05:07:45AM +0000, Matthew Wilcox wrote:
>On Sat, Nov 15, 2025 at 02:51:09AM +0000, Wei Yang wrote:
>> I am not 100% for sure. While if we trust it returns 0 if folio doesn't
>> support large folio, I am afraid we can trust it returns correct value it
>> supports. Or that would be the issue to related file system.
>> 
>> To be honest, I am lack of the capability to investigate all file system to
>> make sure this value is properly setup.
>
>Maybe you should just give up on this instead of asking so many
>questions, misunderstanding the answers, and sending more patches full
>of mistakes?

Hi, Matthew

I am glad to see your reply, but your comment makes me feel frustrated.

Well, I think we still talk about the fact. You pointed out three flaws:

  * too many questions
  * too many misunderstandings
  * full of mistakes

Per my understanding, there is only one question: whether
mapping_max_folio_order() works universally. I think it does and also Zi
suggested to use it. But since I am not sure about this, we can revert it to
keep the logic same as current.

For misunderstandings, I use the word to be polite and avoid conflict. I
went through the discussion with Zi and thought I did what he suggested. In
case I do miss something, Zi would correct me.

For full of mistakes, I am confused. I did some contributions in kernel, small
of course. Mostly correct and get merged. I know sometimes I made mistakes,
but full of mistakes, it seems not to be true.

Well, I still think this is a common review process, I am open to comment and
questions. And also glad to take suggestions from community. I still think it
is reasonable to combine the EINVAL handling, while the detail need to be
settled down. 

Have a nice weekend all.

-- 
Wei Yang
Help you, Help me

