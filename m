Return-Path: <linux-fsdevel+bounces-8622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB4D839A75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 21:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A1228A4C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 20:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B021D5690;
	Tue, 23 Jan 2024 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px2kLZaw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FB0524B;
	Tue, 23 Jan 2024 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706042612; cv=none; b=QZmIfCn4ha12MBgZQbK18ncDgIbWRXvwQMnJ4Lrgj33lwJKMs5vB2fTVSuiKyOM6kOvCUugxENjtmhR2g7WMuluU5i6YXd/InRLTVwvHkTsF9tPBz1UuqMAyJO0Us5Pr7N+D+K1kBBawZg7Q7yeMoxrSLDsShCeo5B2h8uNmhvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706042612; c=relaxed/simple;
	bh=W6mOyfoMO3KQ+hVc2pxuF/PZik6KXYBzJZcB2hwsfiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJG2r6VLJAAA1zHtwMhpydbIey6P7lAw5agOj4XDEqJ1cwsXQuYy76rk8sS4tDFuuajj1OcglGRCbSfRzIDHunVMAYY0WjCk3dz53ajhCgNc85RNe3d6o3hvQ8RtuxGrqd34DwtBIqbF0yKTSN+krizU8oe/UIVj6FuFzmAyw/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Px2kLZaw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d748d43186so18306195ad.0;
        Tue, 23 Jan 2024 12:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706042610; x=1706647410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/M64QxEWn2HynUowyBZgYrVqasAYN5VNMIeSyQ1vgk=;
        b=Px2kLZawBPBjDka7aQZqYY3b9ouwXhSmttWfY97I7mriT1adn0da9c6HNr1+TdXxd3
         NEa6Zc/zHvAN8lhFo9xdkJJQKPUIFXkO53x7sM913ITi4ypngiGXhUxFNz7vSkOTWVyi
         BsFOuIt4FMSYt2teDUyot9wcJ5cfrX0OL/XR6VyRm/1KOrMaLXAkl9QG7l+9FpbkJQSX
         XKW/E4a+bVNtSMeOEMW3W7o6LPSBaVn3a1kQeRR2uUjLnUIcdB2u8M61RUG6qEB5t+bZ
         XW2kza09FXTacr1YpqARNpU5DsNOdrdldk6dF1S9//JyFk1goMo0cf2umtsdB72tfnbQ
         5snA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706042610; x=1706647410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/M64QxEWn2HynUowyBZgYrVqasAYN5VNMIeSyQ1vgk=;
        b=cfdRKOr9AgdnclDiVmu1rXcSr6Lx+Mpj0VdLNhhyEvmc9YJ7WUmucqV7ZLofimYA9p
         1KHQ6ZzrQqnFeJ9BpgZ4t4/XJPBTeZf9yJXjrSrqxT8CcyGGDuJvIU4XyJwuMOmO2ieE
         0VPMpNbh7fYK+vKLqQV8NiV9cusmrD+GkKlOomWbfNFq9H63B0uWdFIDAKVnLAjjrnM5
         HfIvpMx9N4Zy2edMLNYdTq0FaN4gIO9rKmbQ4A3E9atnmQhUP0sLOF3W3ldKEYZKh77a
         +u+IR4PBOe7nG5d1xV7J2KrfukaNWf9WnKJpb7K+jWt6qFgMPqWFr2WszN/b88xnBZJs
         pMJg==
X-Gm-Message-State: AOJu0YycoNuVHIzNjhveYnSfFvXkAhzIjpxkK965eiwF+pXAI8QxDQ02
	69DM95EPdelpCx/DXWiQGJDZHZLVllcRYZOxswTfmc60VBWXmzwC
X-Google-Smtp-Source: AGHT+IFkwmV6/GQzYxMoUXFdqmuslTw5E1Fh5A73QIDIocbRUdPwz7AmIQvOP3orOG+CWkXPoEU4lA==
X-Received: by 2002:a17:903:32d0:b0:1d7:562f:67ec with SMTP id i16-20020a17090332d000b001d7562f67ecmr2594794plr.102.1706042609936;
        Tue, 23 Jan 2024 12:43:29 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902e2cc00b001d70af5be17sm8832683plc.229.2024.01.23.12.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:43:29 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 23 Jan 2024 10:43:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org,
	hcochran@kernelspring.com, mszeredi@redhat.com, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] mm: correct calculation of cgroup wb's bg_thresh in
 wb_over_bg_thresh
Message-ID: <ZbAk8HfnzHoSSFWC@slm.duckdns.org>
References: <20240123183332.876854-1-shikemeng@huaweicloud.com>
 <20240123183332.876854-3-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123183332.876854-3-shikemeng@huaweicloud.com>

On Wed, Jan 24, 2024 at 02:33:29AM +0800, Kemeng Shi wrote:
> The wb_calc_thresh will calculate wb's share in global wb domain. We need
> to wb's share in mem_cgroup_wb_domain for mdtc. Call __wb_calc_thresh
> instead of wb_calc_thresh to fix this.

That function is calculating the wb's portion of wb portion in the whole
system so that threshold can be distributed accordingly. So, it has to be
compared in the global domain. If you look at the comment on top of struct
wb_domain, it says:

/*
 * A wb_domain represents a domain that wb's (bdi_writeback's) belong to
 * and are measured against each other in.  There always is one global
 * domain, global_wb_domain, that every wb in the system is a member of.
 * This allows measuring the relative bandwidth of each wb to distribute
 * dirtyable memory accordingly.
 */

Also, how is this tested? Was there a case where the existing code
misbehaved that's improved by this patch? Or is this just from reading code?

Thanks.

-- 
tejun

