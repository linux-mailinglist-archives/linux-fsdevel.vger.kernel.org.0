Return-Path: <linux-fsdevel+bounces-52837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB033AE74EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 04:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2573E0197
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 02:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD231D7984;
	Wed, 25 Jun 2025 02:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZb497+5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D951EA73;
	Wed, 25 Jun 2025 02:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750819511; cv=none; b=pczXFJD+AyIE1KhrTZnGI599grpGzXKi7HksH/jbI27ctmd67qXJPoC0egc2dQR/QSlbx5v7smcMoASNmLrDUpV9BRXZQ2Y7AE0aHIfhvoIlQjeRDFKcTmugJcp2U+c70Lb62aHsXelQ6aT2ivIAYOESKEj0ewSMrbU3UGs/USY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750819511; c=relaxed/simple;
	bh=KXBPcvjxecqpUYr9b0QhfnTins+ndv5s/62yHwkOtMY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Mu/suYfbVQpkOR+coIonAt+fDxd4/osXHaa54DaYNqqVWmgtGOoY8Bl0kRT9UwdY/L+nUpWQW2j/QXscKV/jQm+sC7HaRXi2JuzaUIy8AiiJP5ZQ1vkWFVFe6dRamG74i4tkpXPMx/3AXu1mMD64r/8UlMhqiIVBcjDc0fw9+do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZb497+5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23649faf69fso62867895ad.0;
        Tue, 24 Jun 2025 19:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750819509; x=1751424309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HhvY7PX162tmc88DemSdBagdKtzFJ3zivqXoYNkomV8=;
        b=IZb497+5NSYUkPOX/o+3taE0Hl1puO4w7i4tID0PqcaTXyBBmmWFwUf+WsoJeKjH+J
         RqLK0CU87JWExyhUJ2APl5C4+X3nj6hpPna4T9yhqQ3gmrAHD+7aHphCCl+Y8dkFos4L
         AyTV0tzePARGjBRxqDTVB06XeKIEhih4aDc3+psc1p+2cyKg3xd3tZ5dABqd5DYQHAQD
         zbb7rA6+kuqGnZAA81WZxoICliHkyIrfjnFUWF+Urfe6SXXoL3ubjK0wRiN2EcdW9Q6P
         zaoPh3HztLVQeSIpX5D0xloansGpQei3bu036XvwlQA0LoXg1Uow/VE5XCPi4HhfNfnk
         ONLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750819509; x=1751424309;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhvY7PX162tmc88DemSdBagdKtzFJ3zivqXoYNkomV8=;
        b=C7PFAz3P2xSHMYcvCSr/cR9TgoOXU+9xvpR6I5sq0b3ZSGc0zFa8hr6eXSTETNCvvE
         t2hHtaZUl0wHnhaTURNqcEaODp1suG7Cps197e14Uk/ygeJNhF4q/J49ByoeevZjt9Ow
         Yi3A1NTL4T6W4qhL91Zp9LXE6PhXHmJnQAwsD/FWgx5Om+ajmPfHgEiJk1E947s4uusA
         3xCtGS7+ah8rbDMfWp2Zji/GOSuldn9EW+vcqobi3GaT1u7sSrF0m+CXUubKy4p6N9AK
         GMeFYy881A/UNOx+jq1GJjuWtjNqJTkAm0eKsC1WSFR1fDliOvgHQFghA8vPs7ec3Zze
         Gi5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBv1iKTbQwJ3UeOYHF3B4iFP51MA8wMWrX15Qxx4IpSkOpRbQ5HYMuMSOOdlgpudAvKTiXX6pd/2Ut@vger.kernel.org, AJvYcCUw8lWJVj3EkUoP4rdPIlp+27VFJopdPDGc81C7Pcg7Z7glH1bxS/cIf0VnyspQ+3cnoFjN3ZUnuQPUXYxm@vger.kernel.org, AJvYcCVQLS64JvPwznn1uoAp5uxbtPiLm3UogJwRpWIk9LFWx3Q3LPbIwfNZxzI94T4SNNEDgR67FoOWOuq8/kKf@vger.kernel.org
X-Gm-Message-State: AOJu0YxQyH8J1whHNv0vbtaIhYqJCVwmwmasnD/qjTLeXbAJMMZ8JK2a
	Ph/LAkwYGnpKG5Vf71gi4NOWz/a3FuFrRdEREepvWqwXJbQ9XO/4n925IZX/SFft
X-Gm-Gg: ASbGncvCmZH21hZTBM7hrEFFlH47H32fsLbs0vhMwOKK4jH3k/I5V2TnT63+bCtZGtv
	ia67sBywuw/vtQT8m85/lLMXhgvEzvRnAYhgUQns8bkwjvkXESns6QY/lKnQ0/zr83G8zY702bw
	VqvrtTfH3/t2uuzOOt40gnod8N50XEz/YiJhGdvK1PlYK2EIObQU+17fXgZSQ0oFULRjmhWXSKE
	ojz+1uM7hOOU9Ml0LqTPouXwtDOpYkoyw3b3rDnncjtlj6WAm4FlZKwf9DrIEVf52tffbl4yuug
	ehQtb0wwBg0FsFShbhwx5Bv6XJZYilS1NlrFSdFO+OmT5MkvD8prufreMyv8guNzWkMvZxzkhRS
	3vQ==
X-Google-Smtp-Source: AGHT+IGilwpb0PS8N8Qub3Hu4wKOpVrVFXvWHbGxddVaNBLTFgdXifsh8aw/8/o0Lpmgs6mF5X3gNw==
X-Received: by 2002:a17:902:e881:b0:234:909b:3dba with SMTP id d9443c01a7336-23823fe1503mr26559505ad.20.1750819508662;
        Tue, 24 Jun 2025 19:45:08 -0700 (PDT)
Received: from [172.20.10.7] ([61.171.244.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d869fbfcsm125015595ad.194.2025.06.24.19.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 19:45:08 -0700 (PDT)
Message-ID: <51cc5d2e-b7b1-4e48-9a8c-d6563bbc5e2d@gmail.com>
Date: Wed, 25 Jun 2025 10:44:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH] xfs: report a writeback error on a read() call
To: hch@infradead.org, david@fromorbit.com
Cc: djwong@kernel.org, jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, yc1082463@gmail.com
References: <aFqyyUk9lO5mSguL@infradead.org>
Content-Language: en-US
In-Reply-To: <aFqyyUk9lO5mSguL@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> That's really kernel wide policy and not something magic done by a
> single file system.

XFS already supports an optional policy for handling metadata errors via:
/sys/fs/xfs/<disk>/error/metadata/

It would be reasonable to introduce a similar optional policy for data 
errors:
/sys/fs/xfs/<disk>/error/data/

This data error policy could allow the filesystem to shut down 
immediately if corrupted data is detected that might otherwise be 
exposed to userspace.

While it’s unclear whether such a policy should be implemented at the 
VFS level as a kernel-wide mechanism, we can certainly extend the 
existing XFS error-handling framework to support it. In other words, 
this would be a natural extension of current XFS functionality—not a 
reinvention.

