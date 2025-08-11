Return-Path: <linux-fsdevel+bounces-57333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE82B20862
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF62D18A015E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9D22D375B;
	Mon, 11 Aug 2025 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AczmBA1o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA522B8A9;
	Mon, 11 Aug 2025 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914103; cv=none; b=bmQJgbI8exKqAvhT8PUHPG51u8y9OcfC/gdVCp151vE94DRDT1P7NLmO+G73rfcGCsfOA1KsisaQyqeTm7EWDbDDoDu3+PpcR7HrLlHPFbpy/fDzpEYLRDCQH00JLluaYbjOqCfy+gFpcpk3oXn7bOIo6GeTx2l6hdnlvGtqIwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914103; c=relaxed/simple;
	bh=UCwzjjviZPPLz2vXc+YOpbT2IMN+yvSFqZtKqJ3etuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOixAkT7oDHQzYKIIyFU+W66OHzBaqSxXF1EcWGeaphgoC8pQDExXZAkSdTjQ2132t7AqvMFYVn89SMNbIm+4U2FSIUZofjSl7xXcV3a/eQQMLxbciplCZWb1ONMOgCF17U1ro8++Wkmbd1ra3kPBhkSXOe+Y0xULCO9Qc9Kcy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AczmBA1o; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76bfabdbef5so3463211b3a.1;
        Mon, 11 Aug 2025 05:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754914101; x=1755518901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GP0IekGVQUa8N0bi2aKaM+2v+1kKu1hhy7fkZ6DITVw=;
        b=AczmBA1oL4Re/zIZeEH1HvIuh8obexRmi3P2gDs/Sia7xTjAHuSWwj1yNdTj+9cg4j
         nS1jOcLc6Z5RMPKSi64q7UMEXN359+Gdrs49agpmy7f8Y88Bvk93Yv+DB4OV4y8GvIvE
         Et1ajECehCwpPFntvFWKRqdhvYPckZPhhzuTlcm/7wBlzqxGZIBvxqacy2ff5lOz3q7V
         ozacfx0k8qqMQMz43BhQ9dO/jhouaKWE2eTk4yJyKLMo7nE9+FHRpwH9EhbI/vlJcC5M
         sNn07YfuB40uN6qqzbWQIbhbfPmxsjEV2KMNVfrX2+iLVEnIGhjCupsZbqb9Itw6S40M
         ZZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754914101; x=1755518901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GP0IekGVQUa8N0bi2aKaM+2v+1kKu1hhy7fkZ6DITVw=;
        b=L9t1Vheybb5ZvN4Z1p3Inrk5LBfJgABK9z3WastymPDNAdplVFzkQBJKWuHzv28xrz
         avErR6JMf6mdLcHUgDKb+15zsO79phMAwyeF/WWVKCsFObz702EVQ/jt0BY/BVc06o/G
         ZDyY8BAMTZbPQtTSg+ZOrO8+3V5OVI0PjhnfLpF/dhPtzm+PLVleWZCJeyReCGrmcZxl
         hQ8uC+gMy+rfejBIlVNmDUag+3x0rT3Tc6/zNyVttyfZkKvoqz6rCbnD+l2J1S5l3XDe
         Wem0UbJdVeD1j9cFgkXIhjZiQAjxPUS0kP4DZjneq8iaFX4DQcLuAYNOGZynORVo3R5+
         LGeg==
X-Forwarded-Encrypted: i=1; AJvYcCUfv4tMTOjlgMszsb3fmi8HuRnDsE+WllyO9WvW8OLSEod5smaSbii5ui9pHlRXpPXM/O59CKKIWDdxoygf@vger.kernel.org, AJvYcCUglsEIdKkSRV/8Zavz0jPQMJ1xPRuOYs/JZMrzU2iT7eI5i4O1pyJT0wfKk9asYLdnLkFdVsP97DY1qtHv@vger.kernel.org, AJvYcCXY2E7p3TdxzmTc6tJ3klOg15YK8BI+x6eO4pgD1IucEZG75WegrvXK0u8gZG0KG/un2PmvpWbyezBh@vger.kernel.org
X-Gm-Message-State: AOJu0YweVHN7nvqe7WG1Bv3JX+PfYFnB3ORBj298QgPnCGLZtN9kai8C
	r4DRNWetihfZHNjp78uhxiKAsCeuDdZKT9zqmwkN2MQ1EV+QYUWHyq3daO+54w==
X-Gm-Gg: ASbGncusw+3hgc3RrE05DxyHXOfZFkQAb6fFNcgxy4bZnLvCDM38Q7OAZUROwhOK9wC
	htQ5hYTCkNIHfC11Ppao7GUyG71preuzKXpo3aPIvrIG2Gbh5h53AZwsvn5zAhoIYwBnIZvM7cf
	NPqHAAliohbKpor9GQrBImLUSy50G55JpR8o5JJFra6v6So+4LS8q0Z4HFV3q1ByE2uF9Ip8PBL
	ThCZi4R9l67nRn6yjVzpRbssUoECF3U2Pw3++X4OL/De26sz0lKO9omhhxHQ3hGM0QFb+oTASTA
	0CdGjSFHDrsTlCTikyZA6gDihityQ3hAkeMn4h7OzkNTqyygTkLUtGKkVvb3RL/eAbN0oAHge2r
	4iiVNcjxrAIF2aXEy200tn1Ni4+xjFFuiv3w=
X-Google-Smtp-Source: AGHT+IGO0N2WzlyFPVmjtOubYJJT3FNBe2WHrsbZh8IuUfVy6/8hjJlLK/SKozCf1Vh2gAGHvNmH5g==
X-Received: by 2002:a05:6a00:1a94:b0:75f:8239:5c2b with SMTP id d2e1a72fcca58-76c461b0de8mr17513166b3a.23.1754914100898;
        Mon, 11 Aug 2025 05:08:20 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbcef6sm26836642b3a.85.2025.08.11.05.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 05:08:20 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: hch@infradead.org
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] iomap: allow partial folio write with iomap_folio_state
Date: Mon, 11 Aug 2025 20:08:19 +0800
Message-ID: <20250811120819.1022017-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aJnIGcIcgjVtZqc3@infradead.org>
References: <aJnIGcIcgjVtZqc3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 11 Aug 2025 03:38:17 -0700, Christoph Hellwig wrote:
> On Sun, Aug 10, 2025 at 06:15:50PM +0800, alexjlzheng@gmail.com wrote:
> > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > 
> > With iomap_folio_state, we can identify uptodate states at the block
> > level, and a read_folio reading can correctly handle partially
> > uptodate folios.
> > 
> > Therefore, when a partial write occurs, accept the block-aligned
> > partial write instead of rejecting the entire write.
>

Thank you for your reply. :)
 
> We're not rejecting the entire write, but instead moving on to the
> next loop iteration.

Yes, but the next iteration will need to re-copy from the beginning,
which means that all copies in this iteration are useless. The purpose
of this patch set is to reduce the number of bytes that need to be
re-copied and reduce the number of discarded copies.

For example, suppose a folio is 2MB, blocksize is 4kB, and the copied
bytes are 2MB-3kB.

Without this patchset, we'd need to recopy 2MB-3kB of bytes in the next
iteration.

 |<-------------------- 2MB -------------------->|
 +-------+-------+-------+-------+-------+-------+
 | block |  ...  | block | block |  ...  | block | folio
 +-------+-------+-------+-------+-------+-------+
 |<-4kB->|

 |<--------------- copied 2MB-3kB --------->|       first time copied
 |<-------- 1MB -------->|                          next time we need copy (chunk /= 2)
                         |<-------- 1MB -------->|  next next time we need copy.

 |<------ 2MB-3kB bytes duplicate copy ---->|

With this patchset, we can accept 2MB-4kB of bytes, which is block-aligned.
This means we only need to process the remaining 4kB in the next iteration.

 |<-------------------- 2MB -------------------->|
 +-------+-------+-------+-------+-------+-------+
 | block |  ...  | block | block |  ...  | block | folio
 +-------+-------+-------+-------+-------+-------+
 |<-4kB->|

 |<--------------- copied 2MB-3kB --------->|       first time copied
                                         |<-4kB->|  next time we need copy

                                         |<>|
                              only 1kB bytes duplicate copy


> 
> > This patchset has been tested by xfstests' generic and xfs group, and
> > there's no new failed cases compared to the lastest upstream version kernel.
> 
> What is the motivation for this series?  Do you see performance
> improvements in a workload you care about?

Paritial writes are inherently a relatively unusual situation and don't account
for a significant portion of performance testing.

However, in scenarios with numerous memory errors, they can significantly reduce
the number of bytes copied.

thanks,
Jinliang Zheng :)

