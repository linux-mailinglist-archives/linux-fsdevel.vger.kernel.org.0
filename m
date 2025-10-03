Return-Path: <linux-fsdevel+bounces-63412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF80BB842D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 00:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC8C19C7207
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 22:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D456A26A1CC;
	Fri,  3 Oct 2025 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JtS/Y2xA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D69220F2D
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759529317; cv=none; b=RtxbzCu+QTYzLjN9bh3jDXs/Uw/9KkagyijRzb/CpIOl3lNCjlOWT+WtgtPGXaRg6MvI/T3QkwxhrI73sQz86a7apmmapR96d2K7XfA+epZgrmAdSeiZj94c5rCSnuqbchisu6VEZRodBOuRu/bOkHPypFMHVi+yWd8lL5k0gwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759529317; c=relaxed/simple;
	bh=sRSDQcMtPln8Ob1FiyqiSyLnZxAWoKjGCLZ9p5KWjCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3CePsCKW5WvJIr9AzVEX9K+o61QrGYzZlrg/QDT7Qza8iVw8FmhGpbc/7QZsqR9oROATmpozSUyrKS1ahRTIgAv1AY7DXcwgmZhx/alkWotJ7I2quzZaVnnQY27CZNMtKViQhWs+5fU8v77M7aDE/5tT/F6Tw1qAa+ImPwI1D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JtS/Y2xA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b00a9989633so139142466b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 15:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759529313; x=1760134113; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6uathj8BKyrpf5AwcT14X9vzYTcIzyT2KAzt9pUyqms=;
        b=JtS/Y2xAeFWiKkhN6DEZ5txDGDt0X12gvddEw0CtWLxXNKZFwI7BJrSUpjdPhI/Qm+
         5naUlSvfkxzh0yluZFtiXUm9IzRcKhBDKfvGJQL6M7vWEjoPhX2cfA8Csf5BmfO6dWik
         PXjlMO8TVb5nn4Avg550VDvM4bX/qgmNhe3bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759529313; x=1760134113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uathj8BKyrpf5AwcT14X9vzYTcIzyT2KAzt9pUyqms=;
        b=o0IOgfEc9bhz3rufT57UdWfz9BXc2iC+dgYqis861zoA/lS3Zc2nhAYzcEnl1POphg
         UZrPkHloI2TBpQXJYDPGa3zTN/ZM7kkhSAnWdGBzqgJA0TDlGpvdgZsXWux0Vgq1NBGw
         MunXeKccNNzs3gaDHgYHNHVXgzfdViNI4EYgOkUiC2kdvGg/jVPGxfKvlV388zZp7PlO
         vQbAEuPmURVZCfNpGolZh5VmVMsvldiW9ZyXqtjM6GD6eydpredz1jMbj04266rhhgXH
         KGGnfFrdtG+eU6DqUGgGPd2XEFpsz3yjbgt9a4n8JCOQZ6YO45VQMhYFvtLJzbx1xtGp
         m9GQ==
X-Forwarded-Encrypted: i=1; AJvYcCViIFrtT3qF5G8LAZCaOBXPZ7aqtkOYcZ2T9lmspVAL9PBSlyzW1CcZn/YZyPb5DxPDfHKfSfmEp0Z+fhxJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzBRjn2Rw0W5mKeNAH9R+pV9iI0B2asY5tbXhMTQndG/cmTUXTU
	bwuVGMdYPFkoMT15LagOmAV6qyKftg8sihDId39UfeQ7/ijSCk0eLsF4ZTNN7GsFKj0IABSWtcP
	JrftqbnU=
X-Gm-Gg: ASbGnctisad96pk3ma306N6qFCG3W8HBhMigqG4f/Tf1QOVK+e+3azkPdIL9CwARVQm
	UeYetMKydpCYPMD9BuFMzBBepzm+mAeRXPW6M+IA8ei+xQd8xnlC47hXedS5jKkSXTpA780PAzg
	WNJ84rIPKAAwsyaj8bcykqEKumSf1UDm80VYJM4SxvSi738KsaJxBj5qkQc2O/TbcnVc40G/EW2
	d/UtpwP7Zz5OqkeKqhddttc72hdyEIM2osZ1JoKqblvCgCsW+DspMAs1zvpujlmVVHKtl2wmwu4
	JEvhZwHxl3H59GlpiWqcldg2MUGjRHYdYjAlCoV4oZCylB/jXu8FySWyGRVhZemUmh3ERZEKHJM
	N2wbzD2IS2ApdkR8KPIy3gSMQAVnI8rUH+oGjbCeh6dGODKvDWPeRWAz/+ORsfLn/2PVd4dpaBT
	JJV6y0q8cFjcEinADZpcn/
X-Google-Smtp-Source: AGHT+IE+shU+BJ8gfYSiQpkCJsfzQq/8Fzzbfh17TOTGvd8z+xVPmNEn65t3gBjX3JTVCrQDx/9mbw==
X-Received: by 2002:a17:907:7291:b0:b04:3cd2:265b with SMTP id a640c23a62f3a-b49c12806f8mr558252866b.5.1759529312825;
        Fri, 03 Oct 2025 15:08:32 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4c1f6sm536414466b.78.2025.10.03.15.08.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 15:08:32 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso6794156a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 15:08:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmN06Jxkq6ODJolWj+BYFpb9Ymp5SvllVEK+JVTn2tR3p8U1RrXiJlvM20JuOEU2ANf16Mhw1vGcX9LKDo@vger.kernel.org
X-Received: by 2002:a17:907:7f02:b0:b41:c602:c75d with SMTP id
 a640c23a62f3a-b49c4297b0bmr594668466b.31.1759529311479; Fri, 03 Oct 2025
 15:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6lzkazta75sjxv2wrxqmskzqzm36zxgbo7w7yjqqlaejbyjegn@tdxtdkkiqzks>
 <CAHk-=wicSxaRNJwTJqvCMCQjoL1KozAdVVq55jYcp-PfgsK2QQ@mail.gmail.com> <aOBEvrdMHCNSYVEt@slm.duckdns.org>
In-Reply-To: <aOBEvrdMHCNSYVEt@slm.duckdns.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 Oct 2025 15:08:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOfheWYqn9g1DFBUHbKsmCdCMsO+jgjBcxRFUVb=pwxw@mail.gmail.com>
X-Gm-Features: AS18NWBsISvpre5F9nmzT_9HetjDjEMRfoqejni0CufFB_ApbhR1jBmsVUK90As
Message-ID: <CAHk-=wiOfheWYqn9g1DFBUHbKsmCdCMsO+jgjBcxRFUVb=pwxw@mail.gmail.com>
Subject: Re: [GIT PULL] udf and quota fixes for 6.18-rc1
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Oct 2025 at 14:48, Tejun Heo <tj@kernel.org> wrote:
>
> So, two subsystems can share a WQ_MEM_RECLAIM workqueue iff two two are
> guaranteed to not stack. If e.g. ext4 uses quota and if an ext4 work item
> can wait for quot_release_work() to finish, then putting them on the same
> WQ_MEM_RECLAIM will lead to a dead lock.

Yes. However, in my experience - and this may be limited and buggy, so
take that with a large pinch of salt - a number of these things are
not the kind that waits for work, but more of a "fire off and forget".

So for example, the new quota user obviously ends up doing quota
writebacks (->write_dquot), and in the process may need to get
filesystem locks etc.

So it will certainly block and wait for other things.

And yes, it's not *entirely* a "fire-off and forget" situation: people
will obviously wait for it occasionally.

But they'll wait for it in things like the 'sync()' path, which had
better not hold any locks anyway.

So the quota case was perfectly happy using the system wq - except for
the whole "WQ_MEM_RECLAIM" issue.

And I *think* that's the common case.

This is when Jan might pipe up and tell me I'm very wrong and entirely
misread the whole issue.

Jan?

           Linus

