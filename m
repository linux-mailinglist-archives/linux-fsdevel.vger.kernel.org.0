Return-Path: <linux-fsdevel+bounces-22657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9349791AE05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 19:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384421F28DB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 17:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AE519A299;
	Thu, 27 Jun 2024 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Wq08l6sK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAC71C6A1
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509180; cv=none; b=uUwr+OZ1jgEyuze7VaB7eTZFhIIQVjw4TODQbPdEnXQJzs9MyqQefVPr8m2eKPmRFCUom/8F8kzgOaW6EmH5afTHAf4JhpsX3D8xnSLuFZsTlWpWKEtUl2vm22DfSuhQkTCE01y8rO6Bf/3jUkhJbyuy4Nmwee31lO1J8JzfF+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509180; c=relaxed/simple;
	bh=mI+XKfUa8Pq9Y0d572iEBS1QCL7aK3vulDO4nqmwVQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t90/kUEp7dcRJdiylZzaTOOm3j++ixMQgftRdufgO38b6bAGROEsJSCd+5iaHUJPIbW1yLJXBmBSUjn1MXlDN5M54vguBi4Uonrxxt56zGPKMgjA39vnsOSMQstitSUB0nlwbwWWQ/cYtkwH7BUPC/sLglBBjlDJse2Y4QRqvVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Wq08l6sK; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-80f6525a0c2so2363467241.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 10:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719509178; x=1720113978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cYteSEYL43wXe9plzRJFQYvXBS4KlHesuROo1/Tu6BU=;
        b=Wq08l6sKvJ/gr6aOCF3RrcMgmrIRULbZZi3xriI8bHQEQ2mhXxsVbr1sITjS1uFTbV
         dL/uMMDWB52eO+SlbbrZrEdALUiO6R+v/g1Vk0QM8CLJcv+UCTUUctWVvs0lEFABSKzo
         4kqQGpOBgdLhMUjC2D0co1VJMOLezvlqda+61MCtgsStCcKFV8fhb3ejbIEjDrzJcrhG
         uJBqT0YxtkRcMBuS4Lx6RlgziPM+nVvqKobVhvrq2YLmJ5uQ/gl6bjZoCltrmRBVDXsK
         q0WMP+wkgwrbT/ShFyMYFV9Ils7GDle4xCtqs7Zv2DngjUhSegiC+Q+VfYUYlFbGYNAt
         tONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509178; x=1720113978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYteSEYL43wXe9plzRJFQYvXBS4KlHesuROo1/Tu6BU=;
        b=wdFAopeXaM+7O0HQwpYVb36MMuQB6DeUDEnnPj116P0+tAlHUv9jkaqjt6BAMPzVSt
         +D/KGKdNWuo//Eg3P4A5thKqlK1Btv2os6dIuT+uByIWn5Qg5WvqTp26HzwLRdf5VkkH
         exz4ShnPukNXscR0crgaQ4gntxcaXgMmst3LxHIe3h+Nc2Umen+6O/l3KToaJuj+Ki9C
         7UQ6/DbTKDSkJjR+rmF9fNqe0OiUe9tQLKEvMzZM9jf0MfTa6TVDzpzcB0gv1/moMwwt
         FOhh85B933iyMhGZVElJPnoMRJa3mz4Y5amCpCLMTlY56GmWLawdNZ4pLPrUIibTq3D8
         KtBg==
X-Gm-Message-State: AOJu0YyciXHA14VZohJFqRIic4KD1DGDTjj7PBU4B1jtYCvsYkDWjje+
	8a2yvNcrJwgcdHMd7IMFl+SZsejcZ77wj9Oh2qv8jQlSyarmzZMW0gcd6COhCHk=
X-Google-Smtp-Source: AGHT+IFATxr121RpfnipD83Mgrv8temsIAtQo4gyAmiqnuLLQu1WehBMLa7VgkH0Jk9esz9GtWRayQ==
X-Received: by 2002:a05:6122:9a6:b0:4ef:65fe:7ee3 with SMTP id 71dfb90a1353d-4ef6a5fe49bmr13726101e0c.5.1719509178277;
        Thu, 27 Jun 2024 10:26:18 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e563230sm473556d6.35.2024.06.27.10.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:26:17 -0700 (PDT)
Date: Thu, 27 Jun 2024 13:26:16 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
	Stephane Graber <stgraber@stgraber.org>,
	Jeff Layton <jlayton@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH RFC 0/4] pidfs: allow retrieval of namespace descriptors
Message-ID: <20240627172616.GB4050905@perftesting>
References: <20240627-work-pidfs-v1-0-7e9ab6cc3bb1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-work-pidfs-v1-0-7e9ab6cc3bb1@kernel.org>

On Thu, Jun 27, 2024 at 04:11:38PM +0200, Christian Brauner wrote:
> In recent discussions it became clear that having the ability to go from
> pidfd to namespace file descriptor is desirable. Not just because it is
> already possible to use pidfds with setns() to switch namespaces
> atomically but also because it makes it possible to interact with
> namespaces without having procfs mounted solely relying on the pidfd.
> 
> This adds support from deriving a namespace file descriptor from a
> pidfd for all namespace types.
> 

I love this, just have the one comment about documenting how the take_fd() thing
works, but then you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

