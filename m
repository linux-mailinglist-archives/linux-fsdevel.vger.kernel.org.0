Return-Path: <linux-fsdevel+bounces-20005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 767D78CC493
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 18:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D611C20D2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 16:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E27C39AF9;
	Wed, 22 May 2024 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A3FkU9+m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020EB1B94F
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716393625; cv=none; b=LNJRZRCFi8NEh02g5s2Thlc/WCAdKT8WcQEOGt+cS14sOjCRcZfwlyGW9ubo0nA5zxofTf3cULkyvIcXwqQdLsn2ESOpuSAAvl92c3CWWaG2CyMV5X1/dHJyI8k3VOx8F3ugpxnLgQsa3Mrj4GIcfoXWk3PGIWTZfjzn41BMnOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716393625; c=relaxed/simple;
	bh=yf2T1NRUeRDA4sbzbywAhB4cFczq2ILeF6v0legvArI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+eB66GA2pIV7CaLORSb4LAOFw0EweInU4wGYRSs2QTLXndkKphrlDpjlh4oyhFUalpTS+Kuq2beSH3zJrRVgINmagam/kxK0Q7l1dvDzoag+6uIYd2mHYZpuS8E+/Us/pQbRiG8kiqjAOjS9k/1cwl0R/fSgGsXeLJ6Q/sN86g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A3FkU9+m; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59a9d66a51so908797866b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 09:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716393622; x=1716998422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cEeqNZMxqfKYuQmEXCXsoXwHfU4Me5x6oZXofMLyGCs=;
        b=A3FkU9+mviqfC2afQVfXxH0kvcUE/0O7moKXLFy5gOuTDrP2pjeD+JIy4Otc6GNdqe
         sljmSdagCSQ957Q1+ANF+2QNQqNJOwq+B8hj3aTg5dy7f+OMm3iy6GABSzw7bgSE6q4K
         wMeZ6bWol4wQsO62OkOk/AmrIXFH3YsisVe1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716393622; x=1716998422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEeqNZMxqfKYuQmEXCXsoXwHfU4Me5x6oZXofMLyGCs=;
        b=AXlS01+UwITtA20FahzaULUCKlqHey8HRawasQFrQXnj5Fm/Z/VKiE5I2XZz5b3BYq
         Se7gzsOcvA9I9pw+mfBFcF+r+vswkg6Twz66sWyCuA7YxJ6UIqDiuxRAmykALKAGa2JZ
         XkoMSpzgeOOqDdtaue/8usgvp/mcpT48X8lc8C5nj1ZH2KL5lbgTFsTGJShfeJCeqvGS
         Bo22+vUszgSuW+j5bUGawJTBYJd6JbN/7MkYiwMFpdd4oetElRmSe9rREaC4AOPpDjVA
         AavFvGxA90OTi7O3UR3hsAj2OBSUVKUGAQdFUpOyoihoZ7SNDjKBTU9F+MEiJfjguRnc
         6qGA==
X-Forwarded-Encrypted: i=1; AJvYcCUMEalNhIiCBy3gzbaXkUqdMrTMvX6X3L6fM4jb3A8Mr99rsRcCig0ffItm13hAoA7uoV2mMEUQf/rFEszGAO86fhuTZzgRz7KVdZ1g5g==
X-Gm-Message-State: AOJu0YythAYZ7KbaDO9A1FDgadN3+qbX3n6VCz8KSzEUnNXcVHF8+A5u
	LKVvOCvM3qqNRO/QwbDjSn0Fd3DkJge1ZPpb9nN3A0JsreD5GjLjjexrT+GMr4LsFzZH5kAH07U
	B15hcag==
X-Google-Smtp-Source: AGHT+IFPe3x8qiaZl3O9uP9XDANbD5P2+9+nPc2yu/nNtyBUX41jIPtNjENwfchEUuyjUYRzQ8/PzQ==
X-Received: by 2002:a17:906:b89a:b0:a5a:8ac4:3c4c with SMTP id a640c23a62f3a-a622818d912mr131935766b.68.1716393622250;
        Wed, 22 May 2024 09:00:22 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a621b339b6asm202439866b.72.2024.05.22.09.00.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 09:00:21 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59a934ad50so980374366b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 09:00:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBUASL1i68WQsChJ0IwfwbYidrjrN/Efsapm/UnTNRa1YNCoNbGOfnMd6+x+0P3mZzs7KbgNMSs2lq68dupzCUaJJCqgANwz+It0Ecxw==
X-Received: by 2002:a17:906:d101:b0:a5a:423:a69f with SMTP id
 a640c23a62f3a-a622806b4c9mr166102266b.9.1716393621105; Wed, 22 May 2024
 09:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515091727.22034-1-laoar.shao@gmail.com> <202405221518.ecea2810-oliver.sang@intel.com>
In-Reply-To: <202405221518.ecea2810-oliver.sang@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 May 2024 09:00:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2jGRLWhT1-Od3A74Cr4cSM9H+UhOD46b3_-mAfyf1gw@mail.gmail.com>
Message-ID: <CAHk-=wg2jGRLWhT1-Od3A74Cr4cSM9H+UhOD46b3_-mAfyf1gw@mail.gmail.com>
Subject: Re: [PATCH] vfs: Delete the associated dentry when deleting a file
To: kernel test robot <oliver.sang@intel.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Waiman Long <longman@redhat.com>, Matthew Wilcox <willy@infradead.org>, Wangkai <wangkai86@huawei.com>, 
	Colin Walters <walters@verbum.org>, linux-fsdevel@vger.kernel.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 May 2024 at 01:12, kernel test robot <oliver.sang@intel.com> wrote:
>
> kernel test robot noticed a 6.7% improvement of stress-ng.touch.ops_per_sec on:
>
> commit: 3681ce364442ce2ec7c7fbe90ad0aca651db475b ("[PATCH] vfs: Delete the associated dentry when deleting a file")

Ok, since everything else is at least tentatively in the noise, and
the only hard numbers we have are the ones from Yafang's Elasticsearch
load and this - both of which say that this is a good patch - I
decided to just apply this ASAP just to get more testing.

I just wanted to note very explicitly that this is very much
tentative: this will be reverted very aggressively if somebody reports
some other real-world load performance issues, and we'll have to look
at other solutions. But I just don't think we'll get much more actual
testing of this without just saying "let's try it".

Also, I ended up removing the part of the patch that stopped clearing
the DCACHE_CANT_MOUNT bit. I think it's right, but it's really
unrelated to the actual problem at hand, and there are other cleanups
- like the unnecessary dget/dput pair - in this path that could also
be looked at.

Anyway, let's see if somebody notices any issues with this. And I
think we should look at the "shrink dentries" case anyway for other
reasons, since it's easy to create a ton of negative dentries with
just lots of lookups (rather than lots of unlinking of existing
files).

Of course, if you do billions of lookups of different files that do
not exist in the same directory, I suspect you just have yourself to
blame, so the "lots of negative lookups" load doesn't sound
particularly realistic.

TLDR; I applied it for testing because we're in the merge window and
there's no reason not to try.

                 Linus

