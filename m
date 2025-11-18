Return-Path: <linux-fsdevel+bounces-68956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E58C6A59E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 76C782C724
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8BC2E2DF2;
	Tue, 18 Nov 2025 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HHqcw1gB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572493148DD
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480327; cv=none; b=uc8o3RkYy95SD55O3XI0T7cFSIJeaTKJVhMMyNotDjztBL46KtHBAb7sXfQKqKfRUPtZIvTlzTfqAZ6RP84Fr99FBgwoP3mqio7EM+pfB9GT52gzE6lQeDSAIk5xT3MojSE14/qNLVVKgZhQ+6r6t9HwQz7npqL5nqpDwx1I/y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480327; c=relaxed/simple;
	bh=hDOXd0eCTllGjlvphmdoQTkCI4o/v1tiBMI/JQFO+Oc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jQnx8v9o+Aqr7Z9lniJZIZT8RUK/GK+FxN5B5wxwhV2wZUQwCxF9kHdo63E27vDWHejUtAePOaD55QhA3fd6/oZDBpt8FO/4B7xTB5XI6NRdBVYvb+uqv1tA2mW7WIsexnCpm9djKkZBkl6yuyw1/7C/70cyXsB0WYZ6A4hShHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HHqcw1gB; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-434a80e5463so7910655ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 07:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763480324; x=1764085124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mop0BXbeVA7pz+P89+67JHjYtUjDwIbDaVAf0R8oLm4=;
        b=HHqcw1gBBMRx4taAkSTWpBBwyTdVqwTxIuNPM3SZCvmXQNm+QHLFFhFoG6S2YvaQhC
         tpqL1nwyku3/VU2gQHGX3mRtU+zhbxbwTDeyjf9jGRJw66WsL4OmjQgdLuZSTFe2+IEi
         TGZwZXS2d2o/65TUSD69ruBySfEXfulRnaWnoSScu05lk/qAgl7/G7rsFsOnkdOrMxbb
         W2ZAqZSSx9phKCptfna3YQCnco1+AK8BM/5FzEsRkXsrR88TtN2t6T9xOkt8UEdjmYns
         yTTAbC9NLAdn7lCGuLiDVYNZhdNr6IcGYwtA/BmpC3FN0mnpo0x5RX5sKUsGdqxVKPnA
         TW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480324; x=1764085124;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mop0BXbeVA7pz+P89+67JHjYtUjDwIbDaVAf0R8oLm4=;
        b=EBDOYl3CugKbgIlQWbDn4gltITydNXGQ4oS7wS6HIBcl9Ff2/gjIwK8+4U31sU/OPl
         WCJKGI8ozdSUH6O1NB6nhIbbdzccj8mLSyo6e0JomZRswA1jCCTI6TzWiQ6Awj8zXYrR
         qHnqlfYDFEM+fPzB0sVqyfykGTuAFui8ktFNDd9mrWEGxGNGlfqzl59V5c9rmB3M3SnG
         Spdk6jotbINtK+pbQ72b0cj3aH828QRD0PeXWK1SiT8n36MJct34qI/Ltv78w7gGnkDd
         5uQhoUgKs5fB94rGZu/zVUhmwnQ+HLDJqXMe03BEd4ZkkmW6hsDuu+K793X4xaQdFGWB
         ZvTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtY9lgAuWg1rJE/TiTvQ1Q93eQpILqdy5yQyJcBKdZ7YL8F0rbDRZgmoYdTjwsVF3zlT4Ap9YPEV14Q1ty@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4WrXMwjhdM/kDiYAO5gOl3+WSxAyIZ48e8qBFdGpx9H2ENqmI
	I8oGxvMhAKUNxVaoG6EpTFfOiQwtzYknsOamIFMmvWOmiT9k49VPoaH5JP4RSeRzl5k=
X-Gm-Gg: ASbGnctpdU3k6IZCQImCNBsDyFwr6voYrskXFcs7HVXGSJj0YYAWNRFD+tPii7vRdA3
	QvBDzcDi6a4HIHzOs8wipu1pcZ6pofEddY6agnP/R+nUvVWHLvNrqGNoiuJBb1czg58sgRdUf1l
	d5C/vnvjc7iF3hnAgN1MrRZVvjyl5F6n/j8TZHLD0l6a7PY9xsHbYwjWoJjhLd4koncxLDXrQEp
	7P1xI+rmCyDCTGELHpRC2K4FYqXcdJuoCmYflfkdoisGuqWU+q8EYyLmOvLda+yJmt/g8tLXK0B
	QyksiMSYyoF4Vk4txROggYueKTNDHG4w73XuT4E73i2wnnLn2PfA3bElbV+orbnCN4bVZYJdd7s
	p3tEWPCAlDyBlb6CqOrmCmixD7vtzsx/HtTEhLx4MwudEiRT19uAcwceNlZj5DrDHj/wDEcf44i
	PJiCJly2+c4paAxg==
X-Google-Smtp-Source: AGHT+IG8+S4XnZehtbJh2wZVxg2hQEO6XU1apy+1d/G7wa7Jeq7lGc5uai8Q9QxowXUoeU7qPJOUrA==
X-Received: by 2002:a05:6e02:1845:b0:434:70bd:8b47 with SMTP id e9e14a558f8ab-4348c8be2acmr204639365ab.11.1763480324489;
        Tue, 18 Nov 2025 07:38:44 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434833e94f1sm83498515ab.10.2025.11.18.07.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 07:38:43 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>, 
 Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
 Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>
In-Reply-To: <20251015110735.1361261-1-ming.lei@redhat.com>
References: <20251015110735.1361261-1-ming.lei@redhat.com>
Subject: Re: [PATCH V5 0/6] loop: improve loop aio perf by IOCB_NOWAIT
Message-Id: <176348032339.300553.10948808566145680135.b4-ty@kernel.dk>
Date: Tue, 18 Nov 2025 08:38:43 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 15 Oct 2025 19:07:25 +0800, Ming Lei wrote:
> This patchset improves loop aio perf by using IOCB_NOWAIT for avoiding to queue aio
> command to workqueue context, meantime refactor lo_rw_aio() a bit.
> 
> In my test VM, loop disk perf becomes very close to perf of the backing block
> device(nvme/mq virtio-scsi).
> 
> And Mikulas verified that this way can improve 12jobs sequential readwrite io by
> ~5X, and basically solve the reported problem together with loop MQ change.
> 
> [...]

Applied, thanks!

[1/6] loop: add helper lo_cmd_nr_bvec()
      commit: c3e6c11147f6f05c15e9c2d74f5d234a6661013c
[2/6] loop: add helper lo_rw_aio_prep()
      commit: fd858d1ca9694c88703a8a936d5c7596c86ada74
[3/6] loop: add lo_submit_rw_aio()
      commit: c66e9708f92760147a1ea7f66c7b60ec801f85e3
[4/6] loop: move command blkcg/memcg initialization into loop_queue_work
      commit: f4788ae9d7bc01735cb6ada333b038c2e3fff260
[5/6] loop: try to handle loop aio command via NOWAIT IO first
      commit: 0ba93a906dda7ede9e7669adefe005ee18f3ff42
[6/6] loop: add hint for handling aio via IOCB_NOWAIT
      commit: 837ed303964673cf0c7e6a4624cd68d8cf254827

Best regards,
-- 
Jens Axboe




