Return-Path: <linux-fsdevel+bounces-73424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5BCD18B95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 13:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85F41300D549
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 12:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB72038BDB4;
	Tue, 13 Jan 2026 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tx5Oh18A";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkhUijY5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3508850097D
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307472; cv=none; b=qcd+uu6KvOLrCEReza9hC/HkIIMkB65UwAUGLeFQSequGmSAQH8lcyzD8egXUQpvbSt+uJ7GF/rTyeplvMJ7L7T/W6yOw87oKhvZsfWYeUxiiunpEnufnWnVcqK93dfJLXeH2dBL8bHmQSgNCps0FyOdnEz8LwpGrAxUww+tyt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307472; c=relaxed/simple;
	bh=dr/deaXgcA6wPeq1B6ILKvHv9WqvrG3xbYZ2Dadm3hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JktHSlhqMhsUirB5s0XGUVGE0OeaGF35JmZlXEDpyGo9U+MukHYUh8UTEX7pbLYAVGLkAVgl8H2BwGqK4mj1nA2j/O/mQJzUcljRo9hndYVybjRep7iXm7yWwwQb6hal3vLugtPySUrrfWJVma2ItiapX/ZUmQhrUO+JyLON7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tx5Oh18A; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkhUijY5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768307465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1kRCPW/g/RoIM20GSJuVNzuIhcgaphVA4TMkA/x3UKo=;
	b=Tx5Oh18AU9H+Fl4CdfL5Xx9gU2lQP03tk32TrkCuBTDWZpDEVg+fWNF3dHFAS0nwAb1JJE
	MWpwlUGRwiC6Yc5+W6FvV3jPffzmHj8HUTKWb0+KJmq9sqgrVmciqwud2hLkX7UliExWta
	RfYbvNruOKDpcwxNjX0INFsCmuirhRQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-VkN5GpxnMb2XQCQM8kPzbw-1; Tue, 13 Jan 2026 07:31:04 -0500
X-MC-Unique: VkN5GpxnMb2XQCQM8kPzbw-1
X-Mimecast-MFC-AGG-ID: VkN5GpxnMb2XQCQM8kPzbw_1768307463
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d17fff653so33397415e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 04:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768307463; x=1768912263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1kRCPW/g/RoIM20GSJuVNzuIhcgaphVA4TMkA/x3UKo=;
        b=TkhUijY52sbTXLlVuHE/KfkS4yiurmXJ6BgH4PE5RhfanczDl91acbveYX2itYPZI1
         EoybkJD5KcGuU9vTj5AYhh9q1EB9ADtfKUgrQpq1mR4yMNFaOvVlE4SghsFVBPIi2OpV
         oVzwifHVduH77ZaqLkHKKGBVGHkg/gmZX7oRttkcCE5K6b/wVwzB3/VB2cEf61kYlRqU
         tqbPjqlL7T+DG4xHiVXVY05f0F+8JiGpx0/SFPpcJa9q0Dd0zZyZ3/5RMgACCNHCLURj
         +lyGGCM6Ly3Pq5xjgwi/73EMcgabkmwV1SEeW0CYnUIsk9dxrVieDmHNlhDF4Vo4ETzA
         vYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768307463; x=1768912263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kRCPW/g/RoIM20GSJuVNzuIhcgaphVA4TMkA/x3UKo=;
        b=bXwPWUm3yIPWhYoVQyemy13Ew9vdbV1V/qPSld5Wi4O4oDkKbr2Lhx9ypzb2Q99DlN
         dTC0jxTo4YynV55X5IF1Ancmce1IyzwUwnqRQYKiQUBzaz30fJBH6NSFTU2ifrlildbw
         P0OXroX8nWHtIa8yos383c/f76i1pa6kO01bWDTwz80tS1/JGwUo/7GLygXJX4EDtRSX
         niG4W39KW+mkp5j8beIeoPggHbnwUEhrTG1dWfzJ8n/btHZ95BG027b1Dqw0MQeBEDMU
         8pTon/n2yOlJMp69EHkG+JeCiFtBIwbialli38jQpupX3hbF+qQo1HLMrVlwFrbimCp9
         c1vg==
X-Forwarded-Encrypted: i=1; AJvYcCUkubUX2KmESJ0tJRuJyt8iYVg2ZBj3y2PZMAuxerAqL3JDLTsN9DSe/qSBjnXVW3AsKeITw6xmeeyIv6pG@vger.kernel.org
X-Gm-Message-State: AOJu0YyqEyr+I7J89S3RHNZN0hVw3p7jH/WTjIkxFHAD1b3Ij8qRjrg/
	X4d/gt7a28QNL8JZe8zioac9S/I2OdF0I0XRbJceAG4BLbtPM2zS/L44cLAF592TqM2Kx3wKr+H
	u7c9JYAv3iuGOwxpcIbUt7iCUJZiq+AGwT4TojQqCJFignnVmC0Xd14PGEBG06kovX/FPSkRf+w
	==
X-Gm-Gg: AY/fxX4CoTLcQW4o680AZTcgoGEN+1rHsEl3sPupTmsXMxUn/gk1+XwpPupUC3JkOXP
	d7T788OzmCWnwqlGB9JN9DdiE4yN/gOoDH1twRPZsJTSicdUaAWrcjt8pjBTkszB+jKkHaOxs3y
	t9jGh4jAmH5XfvSG7dMyOsFOEXALbTEYX1pIvS7Tzrdu+8A2ucn1pAa4LMiRnQREPi7scXdhgny
	EbUdNYBq7a7vlCYMU8/nZBVzkONKuGDAyGo9poY06vIoCH3hHGes06yA62NlV53g4wcSdjK07lo
	JUiveP1o1k9lQ77URSt/27dXtQ7S4zM7WTVAxpsLmb7diYiqpwVuhFcr0pKuCaVlYKbDuDGsIO0
	=
X-Received: by 2002:a05:600c:4fd0:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-47d84b17e75mr242698255e9.11.1768307462734;
        Tue, 13 Jan 2026 04:31:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEv+vamH9clJci/VsanC5PjfTDujMWW6wmVj/wH+rxud84JLfRUY3cNQgVFJ6VRoHnSpduKw==
X-Received: by 2002:a05:600c:4fd0:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-47d84b17e75mr242697885e9.11.1768307462317;
        Tue, 13 Jan 2026 04:31:02 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47eda45ad38sm13548765e9.14.2026.01.13.04.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:31:01 -0800 (PST)
Date: Tue, 13 Jan 2026 13:31:01 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fsverity@lists.linux.dev, 
	linux-xfs@vger.kernel.org, ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, 
	aalbersh@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v2 15/22] xfs: add writeback and iomap reading of Merkle
 tree pages
Message-ID: <6m2lpjl2rgwbil2yixs5s77qzidvyvsrws2x4utvkqyd2exi4u@hqijtifezoob>
References: <cover.1768229271.patch-series@thinky>
 <bkwfiiwnqleh3rr3mcge2fx6uucvvj2qzyl3sbzgb4b4sbjm27@nw2i3bz7xvrr>
 <20260112225121.GQ15551@frogsfrogsfrogs>
 <20260113082317.GG30809@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113082317.GG30809@lst.de>

On 2026-01-13 09:23:17, Christoph Hellwig wrote:
> On Mon, Jan 12, 2026 at 02:51:21PM -0800, Darrick J. Wong wrote:
> > > +			wpc.ctx.iomap.flags |= IOMAP_F_BEYOND_EOF;
> > 
> > But won't xfs_map_blocks reset wpc.ctx.iomap.flags?

It will, this one is only for the initial run. This is what allows
to pass that check in iomap_writeback_folio(), the
iomap_writeback_handle_eof() call. Further folios would have this
flag set in xfs_map_blocks().

> > 
> > /me realizes that you /are/ using writeback for writing the fsverity
> > metadata now, so he'll go back and look at the iomap patches a little
> > closer.
> 
> The real question to me is why we're doing that, instead of doing a
> simple direct I/O-style I/O (or even doing actual dio using a bvec
> buffer)?
> 

fs-verity uses page cache for caching verified status via setting
flag on the verified pages.

-- 
- Andrey


