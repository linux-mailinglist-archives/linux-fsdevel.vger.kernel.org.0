Return-Path: <linux-fsdevel+bounces-20098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6637C8CE111
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 08:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880F11C20DFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 06:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4AC128383;
	Fri, 24 May 2024 06:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzA14FBW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F9E2B9BE;
	Fri, 24 May 2024 06:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716532778; cv=none; b=oknZhO6T4EP4kdu31oZ7NGg6dZ42K+NdxylZif8wPaJj1ZEM2rvwtXSmSbhsMxIqfM1q1AsiwQev8tulb1ah9yQytW5jU+UcgkE5BrJipiJ2EOsvAIfdVFPo0E/R9t2lHkjFmbSa4Krx9y8PdldQESdqHSZwzyg+55qzu+Zp4kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716532778; c=relaxed/simple;
	bh=XgS7332f1wuIA2iErNbzjAalPjhmjOPqPr0f0ii/wCA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=PbLCLJLHBMDEVLbuKfLPdOH952djyiqXvIJRD/Ouy+Ee80tcn4OsJgwRSbynaxhJkP42XnaiD9QxNilzMniFq84qXyN1UVrCve+Xf4N9HF0OgJWTqjzTN5TEU9wCDbDIf6xLlBaVDAa4WaIXhh7U5FOr1ljS2SHzpp62sIapdxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzA14FBW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f8f34cb0beso367803b3a.1;
        Thu, 23 May 2024 23:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716532777; x=1717137577; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HsT7bJXg6clFHv5nP1q6o5UDSMwCvumikRcMv42yBfQ=;
        b=OzA14FBWCkalw5FmDshuFaynhb1xkUpE0w8mQ7LbIjDpWjJMIaPBcZ26FcMlIGO7C5
         m2VPOco7qI8N6TLhIWA9Pu5DxO/EXzihwZ74K7+0kuvIRHm5YuVSlOdSasBiC+I6q4Y4
         ZXOjafZZXs73BKfNJ7X5dJ7x2v3tY4C8Vf9k/9yAaXL/wepx91b/20vT1rJZdeT4I1Ve
         uxTdUGuJYKXSl7UkeVGB7w6oPjjT8xj0yObtB+g5Gocs0BwmxcTpv8OYZxc6hy2UCKGr
         cybjF3jsbfyOIHyIBgbEASatKY5ILgYN2UNE1eiL3xEK3OfWQbcDJl08Wf8+kJBGFNJS
         cEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716532777; x=1717137577;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsT7bJXg6clFHv5nP1q6o5UDSMwCvumikRcMv42yBfQ=;
        b=On6XIjARdYx6jQ1mqk+DK/fHNMpYuJo4RN1txk8A46L2opGiCLR/PitgJmrDyz8/wA
         E72/n96YLnOBSTppwEMF0ve/FwfWKXMu15UBLC0vbf2Tk4DAhri28MzB/bZWOWLDXgzo
         Q7iwT6JxHKILyqyGrVSbQLV18gx/VzeWJkRSk89Fr30DBlxzk8K5YIWWGBEPYo1Z2UAO
         vZmTf0EFijeum7tbL6nRt/O8bQEU531hxz5c/Bs5Yqam81aSybD0xlSYbZ0tb9yf0qIC
         sLRoJdRFZUkBvgzho80fJ4B7PgEKKGZqpOSLfVwAblepZFJfLwp7vIX1fChc7dCmT3mV
         bvNA==
X-Forwarded-Encrypted: i=1; AJvYcCU+jv7lMh2EcLuem/fJNTi2zS3Qp/ww2X7D8LUSrdx7OF9dogdtrBk24w66wwCr0Em+6FCmKegt8USJvIgbnbt5MO1mqoJRqWRRIT29RHGyCl7SCB2KClRWRY+WCMmFVLnfrSWs+g4yFg==
X-Gm-Message-State: AOJu0YzGgPBWeScR5R7Jj81F2UpqS9gNV3Hqj+Bi7dcSiJMVhGf/bhiY
	4rxBu33tJ46d1DZ/X9pasAVsS/UD0Ev2/ZRIjwnWMg2PR79ab4mG
X-Google-Smtp-Source: AGHT+IFZ9+4a4BqTPNNlbl09+d4bQ8gxrwCFrBn4r/+9RqjgoawX3EUMlLrRPNdbolpuIaWUJGwPuQ==
X-Received: by 2002:a05:6a20:3c93:b0:1ac:de57:b1e3 with SMTP id adf61e73a8af0-1b212b044a7mr2178789637.0.1716532776613;
        Thu, 23 May 2024 23:39:36 -0700 (PDT)
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbeada4sm556314b3a.102.2024.05.23.23.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 23:39:36 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christian Brauner <brauner@kernel.org>, Xu Yang <xu.yang_2@nxp.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jun.li@nxp.com, djwong@kernel.org, willy@infradead.org, akpm@linux-foundation.org
Subject: Re: [PATCH v5 1/2] filemap: add helper mapping_max_folio_size()
In-Reply-To: <20240521-beinbruch-kabine-0f83d1eab5e6@brauner>
Date: Fri, 24 May 2024 11:51:33 +0530
Message-ID: <87pltbspaq.fsf@gmail.com>
References: <20240521114939.2541461-1-xu.yang_2@nxp.com> <20240521-beinbruch-kabine-0f83d1eab5e6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christian Brauner <brauner@kernel.org> writes:

> On Tue, 21 May 2024 19:49:38 +0800, Xu Yang wrote:
>> Add mapping_max_folio_size() to get the maximum folio size for this
>> pagecache mapping.
>> 
>> 
>
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.

iomap_write_iter() prefaults in userspace buffer chunk bytes (order
MAX_PAGECACHE_ORDER) at a time.
However, the iomap_write_begin() function only handles writes for
PAGE_SIZE bytes at a time for mappings which does not support large
folios. Hence, this causes unnecessary loops of prefaults in
iomap_write_iter() -> fault_in_iov_iter_readable(), causing performance
hits for block device mappings.

This patch fixes iomap_write_iter() to prefault in PAGE_SIZE chunk
bytes.

I guess this change will then go back to v6.6 when large folios got added to iomap.

Looks good to me. Please feel free add - 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.fixes
>
> [1/2] filemap: add helper mapping_max_folio_size()
>       https://git.kernel.org/vfs/vfs/c/0c31d63eebdd
> [2/2] iomap: fault in smaller chunks for non-large folio mappings
>       https://git.kernel.org/vfs/vfs/c/63ba6f07d115

