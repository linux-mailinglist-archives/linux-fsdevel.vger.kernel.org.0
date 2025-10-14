Return-Path: <linux-fsdevel+bounces-64159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD9EBDB4E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 22:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D568E3AD572
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 20:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865223074AC;
	Tue, 14 Oct 2025 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="D74hUHsV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0DC2C21FC
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474756; cv=none; b=tRlEj3HfKy5bjJEqQ2qSuwCDBfdKD+I1GOA2r8EUotViNOR7M4GM0o+OIVzasm7MGjkULqL6n65tY1moNXtjl/HX3ItD0CDvgrXpxF6+TdISSK78QICXa6f5u2vjmr4JP8i5gPjUmF/a7NKTC+av3BYpyGESY0kYwbKsDEkkC44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474756; c=relaxed/simple;
	bh=mLMiOvkuQ1waPsYJBAJdPUyickusJQ8ORxj4y3Zep3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BP+K++VmIgvC14Eu0ip+2aTyDEZRdGmaH05GvE+D2OCdMUZh+6ylst0qTuHQe7t3otGXpBgo1bovf9KvoAhw/y2QlSjysTY5uVEYCtR3dYNb+uC0VGWqyMcal4owdbtPwPFuFvXXOD8yhvO0KseNrPOhn2p3op1uVvex5PsT4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=D74hUHsV; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso1081203b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 13:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1760474754; x=1761079554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ProMLWdJiYhd+ReUg4Q/nfu5OGup3NKBCnvPEIlS8hk=;
        b=D74hUHsVIAuXAszKT9OyaSP01aDFJeS4dtESAdmyVJsGXoAAl6SoLYFzgqG8sO3LVj
         6ERxo1FSU1Y3JKmYIIaOBI7kPi3x4Gpy/qkXd2rlwvWCRrTYb1eyGj+5O2baZ6fukQik
         Gb4qo2yhiBLvajFZ1uKdHX00YcoaXpBLLYt1ZH+9jgc4mxK3LSaG3HibkB4KlKCev0e7
         3Xiuj63FONPcDeoK99vIV5AkSYSkhgQq6jbXRMFs8xps1Rd79gaHNdZeCeH0pQZyYIlX
         43GH4VKUCNcsCnnFnPE93PllXNK2XvANDk2T9wezW0mBUN0nkZ9WgYK8q0nQIF3CpbgA
         CMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760474754; x=1761079554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ProMLWdJiYhd+ReUg4Q/nfu5OGup3NKBCnvPEIlS8hk=;
        b=JOlmfKmJTV8k0G5O0rGxkTXQLY3u6fDdXJfREHD1f//czTeGxlx+lP/UyoXaPtjLcR
         9JOH/nFQV8Cl1yO9PfhMe+AYjv4029CE/MiVNzL61UXTvX91t8Br1uR2UwIue2bX6F39
         YW/vSdcHdWbhdawhlSOP/BiCjRz0XS0b8T76c6a26JjRHkKnv7aElmijs1SC3nhFAn/n
         HVW0kK8UYy73ro0O1cOUcrC0meMwTa+V6tEcGPRuhmS5wZzNAR9AztWq5Qe2T10XXln3
         MiZJhWwfOO85ZMyoIpYGWTJuk7g0DNlAjIHwDdtwMXtbtpHq1ur8XJswLhs7F2CZAAI7
         EHHw==
X-Forwarded-Encrypted: i=1; AJvYcCUThHaldhew+/Op954y0qQZzni7o4BT8yI58WC3S7gkngaVFhbFZ/9FnXUoJ4tEb5k6xF6zST32lvxq7Mwu@vger.kernel.org
X-Gm-Message-State: AOJu0YyIQ5S4DFLKKrJP1JeSdnqjt0SyZlbje9V8quUe8iaUgDqD4ZrV
	1Apd7anwVojNnaj6D/UoC9JS1S0mGSpCDMAhLc9a+gnYgGnA7oDyTX+DusZx7OmCEWM=
X-Gm-Gg: ASbGnctPvv68it0/NsW6mBPu3gjn24daFuf9AY5CxoL6ebUpOd558/7pLtDDUIi8ah2
	hWTCicGtttCHKRCpLsOiKDgPW7hvWKMsKBXSyWPVCA8OkxlU3g2h8xJ2yKEzS2fvRJ4g2Wd87oB
	TUFxyzlGDNeEFtmpHwAxCO7aXm5RRv9iZyifBe8JKX9nO3fGBh6rc7HVh7YVtSOvazMopJd9KQL
	5pP0t9Grqx3GjsSpi3dv2Sth6WQ61eUAhPwSTzcLgHeEU2wcJhCUYIIbOGWwkXQXzF/XOZocHlr
	8mR0Sojll6yy7nhZo6qac5LgtDEjhA1Tk20WJNLAeuuF30Z5aaK9hAmoqqB0j7BMPwu0azTAWlP
	6hMKPSb+Q99+yWUxCvkHvICQCDRkskO5k0PaxCIZAZxp2IVzo29bi8eApkkhIb/DbLI22AIP8iY
	I0kh7D2gaNA//O38/+
X-Google-Smtp-Source: AGHT+IEha/464YLIDe1S05FMmmIwJiiHJqNozxP/E/7ahWiUSHSloNCgr/S9uHudRNKH/rfSTuG4WQ==
X-Received: by 2002:a17:90b:3947:b0:31e:c95a:cef8 with SMTP id 98e67ed59e1d1-33b5139a259mr32044929a91.32.1760474754350;
        Tue, 14 Oct 2025 13:45:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b62631266sm16839994a91.3.2025.10.14.13.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 13:45:53 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1v8lu3-0000000Es6g-0Y5G;
	Wed, 15 Oct 2025 07:45:51 +1100
Date: Wed, 15 Oct 2025 07:45:51 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	v9fs@lists.linux.dev, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net, ocfs2-devel@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 06/10] mm,btrfs: add a filemap_fdatawrite_kick_nr helper
Message-ID: <aO62fx2B5ZZLsRVM@dread.disaster.area>
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-7-hch@lst.de>
 <74593bac-929b-4496-80e0-43d0f54d6b4c@kernel.org>
 <4bcpiwrhbrraau7nlp6mxbffprtnlv3piqyn7xkm7j2txxqlmn@3knyilc526ts>
 <20251014044723.GA30978@lst.de>
 <qh7xhmefm54k3hgny3iwkxbdrgjf35swqokiiicu5gg3ahvf4s@xhyw4sfagjgw>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qh7xhmefm54k3hgny3iwkxbdrgjf35swqokiiicu5gg3ahvf4s@xhyw4sfagjgw>

On Tue, Oct 14, 2025 at 11:33:26AM +0200, Jan Kara wrote:
> On Tue 14-10-25 06:47:23, Christoph Hellwig wrote:
> > On Mon, Oct 13, 2025 at 01:58:15PM +0200, Jan Kara wrote:
> > > I don't love filemap_fdatawrite_kick_nr() either. Your
> > > filemap_fdatawrite_nrpages() is better but so far we had the distinction
> > > that filemap_fdatawrite* is for data integrity writeback and filemap_flush
> > > is for memory cleaning writeback. And in some places this is important
> > > distinction which I'd like to keep obvious in the naming. So I'd prefer
> > > something like filemap_flush_nrpages() (to stay consistent with previous
> > > naming) or if Christoph doesn't like flush (as that's kind of overloaded
> > > word) we could have filemap_writeback_nrpages().
> > 
> > Not a big fan of flush, but the important point in this series is
> > to have consistent naming.
> 
> I fully agree on that.

*nod*

> >  If we don't like the kick naming we should standardize on _flush (or
> >  whatever) and have the _range and _nrpages variants of whatever we pick
> >  for the base name.
> > 
> > Anyone with strong feelings and or good ideas about naming please speak
> > up now.
> 
> I agree with either keeping filemap_flush* or using filemap_writeback* (and
> renaming filemap_flush to filemap_writeback).

I'd prefer filemap_flush* because most people are already familiar
with that naming and the expected semnatics. But I could live with
filemap_writebacki*, too. Both are better than "kick", IMO.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

