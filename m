Return-Path: <linux-fsdevel+bounces-12827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F94867A32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 16:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A3DB3994F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 15:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9283E128368;
	Mon, 26 Feb 2024 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sg++0gb1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FB52AD16
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961022; cv=none; b=DTE6/DPVQ+IUAigOVzujzoVHm+cZ3XjCHCfqpLkOOX91yFzprGEgGDbWT6mPGg2BwiuZf6P7a7xewF7g4AcZ4DLfv8of8TSxS2W06Ry8Sn2QvrLzccAlY1BZNkMO7okk0t35hThJUGwstiwoTGnRPJAdF1q1iz/3IxO2gF4Itk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961022; c=relaxed/simple;
	bh=0yL7CUIBun2lrzCskDXcvuoIjfIf2TgNBUjAwB5mOPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuzRYzIUjv8Z97Y3rRvR8LSs8AmQu2N6shP+Od1K5EJZ5kV6M0dkDb0hqVDOh3Md8AHcJMboGWckl64sqXioawXAxhWx2mcS7SvP9vD30UuBHfuVktEGoHBUhtLz02Ia8pqj4WL2j730frKNEzxz5RL7oH9EPXaFC5BJFodiN6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sg++0gb1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708961019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X82ljcqVMuswfEdrhconK8WbAqpuJts6cOL6vbrS6vs=;
	b=Sg++0gb1JnM2mVkpb3Vk8zO3nPoFTaQNCDwpN8Q4bH022wMmX7DP2hwqPuDxt4ljTyAAIX
	rmXGG4Uffuz52e2FNbLtvXEX8Kph/gI4k25q9hzjJ2wtFTSQPncWub7avRPcCu6+rbvQDZ
	1Oj3OR9kdjR0aSwRp+fb2suCf1898E4=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-zmSLL52WP961BqSCUrrfzA-1; Mon, 26 Feb 2024 10:23:37 -0500
X-MC-Unique: zmSLL52WP961BqSCUrrfzA-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c7877d4e2eso364398439f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 07:23:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961017; x=1709565817;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X82ljcqVMuswfEdrhconK8WbAqpuJts6cOL6vbrS6vs=;
        b=TlpxrYysrN9RsDiO762Q/4JA4FxIEU9mKk6526zbx+9qNMG8nCHCnjNFQ77TRssvPl
         bQpV6Vn2LB3QMz2+XsyU4vMRMgpdm628t45baXrd395DE25rZLAAKHZ1go2WfqEg1eVv
         EtkdMbFS2EXUSh66R1oM39MeRU/CIlUqwwpr5/0GpioFqE1oxAErjOh5tMLsH/YTbeNn
         NWbZM9neZLkiNF2Eil+T7MDk52sgopFRg398R97JaOIxk901XYBi91sCl7tvIUYMeB80
         wgewNU+SosXra6YLSPePiGgIyOJNqs3dIXDFO1LbWONw8HI5um77d331m8f+jbESbeXH
         RP5w==
X-Gm-Message-State: AOJu0Ywno6vYX4HnnpMpaIdMkoGjI1qwuPh1W+geP1KvFQ7/5nFWJXVJ
	VF4G+mRALUcJ0cPLwVLqG8s90cQMkw2RlZ8th5hSYm817CezBYMRFfPI1YsQ8wzpLGblz1oyVB9
	o2EBSHgnn6fIsp1jvWEZGs63AOZT6nvwtzkYcF1+4t6lxrSydO01Ml+ZTg3oCqu0=
X-Received: by 2002:a6b:5a11:0:b0:7c7:6f8:c653 with SMTP id o17-20020a6b5a11000000b007c706f8c653mr9366332iob.2.1708961016787;
        Mon, 26 Feb 2024 07:23:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHv9jfb8poRgL1+RvZvd+OFzF6J+70cE3r3H78jMDlnMl17HWsUeBfovU+Ou6R54Ji19G9tKQ==
X-Received: by 2002:a6b:5a11:0:b0:7c7:6f8:c653 with SMTP id o17-20020a6b5a11000000b007c706f8c653mr9366309iob.2.1708961016464;
        Mon, 26 Feb 2024 07:23:36 -0800 (PST)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id d38-20020a0285a9000000b004744f62d8ddsm1334683jai.168.2024.02.26.07.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 07:23:36 -0800 (PST)
Message-ID: <4d5f6969-8abc-443a-a395-d511b4baa99e@redhat.com>
Date: Mon, 26 Feb 2024 09:23:35 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] vfs: always log mount API fs context messages to
 dmesg
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Alexander Viro <aviro@redhat.com>, Bill O'Donnell <billodo@redhat.com>,
 Karel Zak <kzak@redhat.com>
References: <9934ed50-5760-4326-a921-cee0239355b0@redhat.com>
 <20240226-geboxt-absitzen-57467986b708@brauner>
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20240226-geboxt-absitzen-57467986b708@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/24 5:27 AM, Christian Brauner wrote:
>> * systemd is currently probing with a dummy mount option which will
>>   generate noise, see
>>   https://github.com/systemd/systemd/blob/main/src/basic/mountpoint-util.c#L759
>>   i.e. - 
>>   [   10.689256] proc: Unknown parameter 'adefinitelynotexistingmountoption'
>>   [   10.801045] tmpfs: Unknown parameter 'adefinitelynotexistingmountoption'
>>   [   11.119431] proc: Unknown parameter 'adefinitelynotexistingmountoption'
>>   [   11.692032] proc: Unknown parameter 'adefinitelynotexistingmountoption'
> 
> Yeah, I remember that they want to know whether a given mount option is
> supported or not. That would potentially cause some people to pipe up
> complaining about dmesg getting spammed with this if we enable it.
> 
> Ok, so right now invalfc() is logged in the fs_context but it isn't
> logged in dmesg, right? Would it make sense to massage invalfc() so that
> it logs with error into the fs_context but with info into dmesg? This
> would avoid spamming dmesg and then we could risk turning this on to see
> whether this causes complaints.

Hm, yeah that would make sense I think - less consequential messages go only
to the fc, higher priority messages go to both fc and dmesg. (userspace
could still filter on severity for messages in the fc as desired.)

The interfaces are already a little unclear, ("what is warnf vs. warnfc?")
without reading the code, and this'd be another slightly unexpected wrinkle,
but functionally it makes sense to me. I wonder if a sysctl to set a
severity threshold for dmesg would make any sense, or if that'd be overkill.

> You know you could probably test your patch with xfstests to see if this
> causes any new test failures because dmesg contains new output. This
> doesn't disqualify the patch ofc it might just useful to get an idea how
> much noiser we are by doing this.

Good point. Ok, it sounds like there's some movement towards agreement that
at least some messages should go to dmesg. I'll dig a little deeper and come
up with a more solid & tested proposal.

Thanks,
-Eric


