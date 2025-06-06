Return-Path: <linux-fsdevel+bounces-50841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 943C8AD02BC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 15:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48B8F7A378A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 13:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09771E3787;
	Fri,  6 Jun 2025 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0B41l3F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A13E3234
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749215056; cv=none; b=sHOiPd8s6gg8damOsxZiyxT/pukAlejHzctRDPyXzQaZjyz0Vrbfc/iqWDFQr3LzPxy9VWPh/bEMNY/3L3hjPoLFq6827D4M6ZfCZLBM7udehS9PVoerY8vDNUEzAHeBWDueuz0lgBaOVdEJYrnMsdVCbeyx3tKXZw+8DwTOK1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749215056; c=relaxed/simple;
	bh=6jsVoGWo/dSumAGNOxr7UqFGaeO67eYLVmbBwUc5Zos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSkrvsIk7b3Wtcd0DhiUukGgUQAqtpHGQTbLrtwmhHhb9JaeRBgMDLBNOKl1Juc2uI48VBo52V5SScFJGHLnVVWETDaH+ffnOFGONH1eHIqoNKqKlHa0zcux3+n2GM6OWkroYdGh8XiQj6jTdrzQ8wLDbADmAiViwwueC5YRHD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0B41l3F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749215053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HArWEAkGZW4SwR4M4QK2P5FGuqV07y/wP1+Sj+8Jiv8=;
	b=F0B41l3Ft6fVAklvxtVFNgT63yyDf/elwWynnOkKHp2BlVc/K9FZ4MRYV2J0ZWrsxSIFZa
	f36m8NSyUH5c+ecRgY6LWZ/K0/6EAy6CeYieqyRP3DkkowoOgguAbIWlWJU/ht1jfUUHfh
	xtnM5j7NcdRglR3YJyFxO+DBzkr/aUg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-pgDEg6g4MR6Au0Jb2rXNxQ-1; Fri, 06 Jun 2025 09:04:12 -0400
X-MC-Unique: pgDEg6g4MR6Au0Jb2rXNxQ-1
X-Mimecast-MFC-AGG-ID: pgDEg6g4MR6Au0Jb2rXNxQ_1749215052
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6face35aad6so19183286d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jun 2025 06:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749215032; x=1749819832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HArWEAkGZW4SwR4M4QK2P5FGuqV07y/wP1+Sj+8Jiv8=;
        b=My3fU/m4ha/YuP6hOyTzaAT7+vI4NlUHmvd7a7As2YihwzGuhp9FeO/i0y5Wdr+ChQ
         pV8Rtwvz0t5SeDdwOKAeDHxLrc5zA+Yyg6UXRlCCvaVgAHPBNSggtSQ+Slye5UCz4kdZ
         bVcu5wda5Cu0JK/x23nWH1t7BJ32xswHnqSh42OYfRygmxyjSVX/2srqRmyK7vR5W8wf
         VoSgq51Gjald2z1iSmp+EdOHORxhSKT92o9qoVgubFvFg7eOKQMAvKvPe/FQxrkvyS1z
         LBp7+u7jNKULggi3M92TIJPYnbznYoST720HuiR70uWC6lyiIqB+arBKLpPFZxreAzpZ
         Mkvg==
X-Forwarded-Encrypted: i=1; AJvYcCUutw/N99mtYsAeCGmv1GVSNmWhEq6+Eh7VHySPtbO+rzO6zGOEAKUBUptIf+8mzx2tGkEWOI6+6V8Nfswp@vger.kernel.org
X-Gm-Message-State: AOJu0YwoOsFx2/7/6+mh77WgeJ7TV0ZCjdwixIUEHfD7cz12MORASNSy
	dxhhqX+WtwR1eNDhEiFM7BoGGUvvc9pSl7MpHvg+qZDfF2hgFS6h/IUjklkjstlD/GTGhSkcjOi
	wQ++MTcRnYs1ehoIujSiAjrI7SndkcD6VWA2c7o+ryGZhTMLzDZs+B56hMsZ+60euyok=
X-Gm-Gg: ASbGncurDFS/vKnL3Xo7wkDGSS+yPMfS/HDg2U3E+wN3YHHH5LwpY5dyCsy31CP1yoK
	9hUHpCn2rdK2id/iCzW2beMda67uJJTMWdaM6g9655TElr1RDzh7fc2nq7bvuXYrY2dqGVfSnYu
	x738tBat14Rx7x4HZXYRgSP5yAozT0FHGEzckMFs3gFtqz0hMBVxUXp9yCTC1QU7vU/W4iFyPgc
	57OTkBKJnH0aUnyE0JpfwFv+iTl/Eemr81JKQ+bjlRArMToBbgzsfLXgRnpatVlNoZn4LNSpElU
	BpKsQKZ57Xidiw==
X-Received: by 2002:a05:6214:21ad:b0:6e4:2f7f:d0bb with SMTP id 6a1803df08f44-6fb08f4307amr50047526d6.4.1749215032367;
        Fri, 06 Jun 2025 06:03:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9BHHM9w2tx8ul52pjQVd+s0UKMZd6LqtfDIdl4wDxhdTCW98c/Y1W4GzTHfIwhEhwfgDeWw==
X-Received: by 2002:a05:6214:21ad:b0:6e4:2f7f:d0bb with SMTP id 6a1803df08f44-6fb08f4307amr50046486d6.4.1749215031425;
        Fri, 06 Jun 2025 06:03:51 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09ab8a19sm10972746d6.8.2025.06.06.06.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 06:03:50 -0700 (PDT)
Date: Fri, 6 Jun 2025 09:03:48 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Tal Zussman <tz2294@columbia.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Pavel Emelyanov <xemul@parallels.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] userfaultfd: prevent unregistering VMAs through a
 different userfaultfd
Message-ID: <aELnNH5LTFHmtdfQ@x1.local>
References: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu>
 <20250603-uffd-fixes-v1-2-9c638c73f047@columbia.edu>
 <84cf5418-42e9-4ec5-bd87-17ba91995c47@redhat.com>
 <aEBhqz1UgpP8d9hG@x1.local>
 <0a1dab1c-80d2-436f-857f-734d95939aec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a1dab1c-80d2-436f-857f-734d95939aec@redhat.com>

On Thu, Jun 05, 2025 at 11:06:38PM +0200, David Hildenbrand wrote:
> Not sure if relevant, but consider the following:
> 
> an app being controlled by another process using userfaultfd.
> 
> The app itself can "escape" uffd control of the other process by simply
> creating a userfaultfd and unregistering VMAs.

IMHO it's okay if it's intentional by the child. E.g., even after this
patch, the child, if intentional, can also mmap() a new VMA on top of the
uffd tracked region to stop being trapped by the parent.  The parent might
still get a UNMAP event if registered, but it'll not be able to track the
new VMAs mapped.

Thanks,

-- 
Peter Xu


