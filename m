Return-Path: <linux-fsdevel+bounces-29533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EEE97A8EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 23:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC95C2893DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 21:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CB19443;
	Mon, 16 Sep 2024 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Fxa64976"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD3A4D8CC
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726523735; cv=none; b=kZ3q+ZP3zUGsVHXjk3uPGEalNMlPlx0+mvgMee8jB6NoTw627cNL2J4KsqYNbDUpJahxYxnkrLYfK4ZpQXt9f74KSXDq1JWN/MjfsdERFMEa0GcfZ6RD9wLvC+NJ9IBMF5814xDml6iHj2ROOC4JyE8BJ99gXQog93ifT5ayZcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726523735; c=relaxed/simple;
	bh=dvdb/hPpUaIakFW38vCDL3nT+2nz/7o6ghkRKdQ6CU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZZyB8LFRH1ex4U32mqLIC1IaH+hvuLSxuvevuJF4abirQF6CyYs8DihNBW+Xgp4k4ElEnFkpEyVkaphjZJvweZzFXpGH60gJq66dktGl84FPi/x3Z35XSjHrJWqjmGay089mMFDVYxIy/5r9wV+6msk7STZ+dSDtCdHIhig1X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Fxa64976; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20688fbaeafso42052985ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 14:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1726523733; x=1727128533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+QcDyNxCWCtWt9+G6UHYM5MMFaIylSmdocAH+GqoOc=;
        b=Fxa64976TA7DtMxglyvo+6ObR75CazhewmJo1VoSdVwZHOHeYjrN3k7/+X9WF8RQ7W
         u4QByY1vEBGgj2m640CWQ1Uh68js277k6m+YwIjt8SO21P75SOhllw/N/GgMEX0m8+oA
         JvCv68RUC/aZ5VCR9wnk5jiZwGtcDkat9Fg2jp4nZQunVtAHobSjUP1dneE4CN4NTFVa
         gHk8PA/eDCqpNcZeS1XGd7oqBsBUHeiE6sfWHH1FdBLCc2znYkNvkNPH09hjGTkeUYYo
         genM5QQQIHsrTr+zmGWg7V5+exYEN76ZGSbWj4A7daN+QWGrj+5a3PbaAbS08AvJ50kL
         JbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726523733; x=1727128533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+QcDyNxCWCtWt9+G6UHYM5MMFaIylSmdocAH+GqoOc=;
        b=AsfFKoEiTbHgSesWEZ5L50zq8nc8LEgwsuJP3D71eOopD9c/iIky9AGoiKLtvj5VOm
         zYYY3+yhiXcoxl9s8CUAjch3tB9AETruKUisSwe/aRdt0wYmAwF1rTdZW5pCp13J0PbM
         re50EajAR6MsWpfoPXVqvDThQZQO/Ho4oxDqDmqznPfrnPZ5gfaDTqQfbshuAKO0Uvul
         NE4/Q4ZJY+g24oaoL7NEY7gzKBROLQzS9JkVxcsG9rFARr5k7QjaPOTnAvTJ3QU+4gUB
         6ya3NcHy6//MnXWX7PpV2WFBqnKgn+vdD7XJouVsPggmCCDQk/sC4aRFLFuDiyWWcrYz
         SmIw==
X-Forwarded-Encrypted: i=1; AJvYcCXW/dR3w0qSWuETogfYmWXZZbDZbGmuu9DTH1Qcmi9e5yCOwRMVVDCBQs2B6mDRY1eISIMgxdULc3xb+mwM@vger.kernel.org
X-Gm-Message-State: AOJu0YxGeQlmvcWNvU74ID8Ow8ZmUNu4QDUxCYuf6eMOOnAq/cUSQaa1
	pLWDC5PR1pWi3Of9wlOIgSrRHsoJVH47tNinL43YopXvIadNd/CEdFimd2P7/K4=
X-Google-Smtp-Source: AGHT+IF0iFN6cnO2/4mZbjdywZwBn/2zzJXSThiMoB3CX3BD1WHtQH9VedLiduQdloMWcI2cvwTppQ==
X-Received: by 2002:a17:902:c946:b0:207:5ca3:8d23 with SMTP id d9443c01a7336-20782b9e330mr183198465ad.59.1726523732632;
        Mon, 16 Sep 2024 14:55:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079460111asm40742535ad.90.2024.09.16.14.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 14:55:32 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sqJgv-0066Fa-1C;
	Tue, 17 Sep 2024 07:55:29 +1000
Date: Tue, 17 Sep 2024 07:55:29 +1000
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: trondmy@kernel.org, Mike Snitzer <snitzer@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] filemap: Fix bounds checking in filemap_read()
Message-ID: <ZuipUe6Z2QAF9pZs@dread.disaster.area>
References: <c6f35a86fe9ae6aa33b2fd3983b4023c2f4f9c13.1726250071.git.trond.myklebust@hammerspace.com>
 <ZuSCwiSl4kbo3Nar@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuSCwiSl4kbo3Nar@casper.infradead.org>

On Fri, Sep 13, 2024 at 07:21:54PM +0100, Matthew Wilcox wrote:
> On Fri, Sep 13, 2024 at 01:57:04PM -0400, trondmy@kernel.org wrote:
> > If the caller supplies an iocb->ki_pos value that is close to the
> > filesystem upper limit, and an iterator with a count that causes us to
> > overflow that limit, then filemap_read() enters an infinite loop.
> 
> Are we guaranteed that ki_pos lies in the range [0..s_maxbytes)?
> I'm not too familiar with the upper paths of the VFS and what guarantees
> we can depend on.  If we are guaranteed that, could somebody document
> it (and indeed create kernel-doc for struct kiocb)?

filemap_read() checks this itself before doing anything else:

	if (unlikely(iocb->ki_pos >= inode->i_sb->s_maxbytes))
                return 0;

i.e. there is no guarantee provided by the upper layers, it's first
checked right here in any buffered read path...

-Dave.

-- 
Dave Chinner
david@fromorbit.com

