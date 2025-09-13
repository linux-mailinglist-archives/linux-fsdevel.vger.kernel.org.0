Return-Path: <linux-fsdevel+bounces-61154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5714B55AC0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 02:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D8BD4E17ED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 00:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAD1634EC;
	Sat, 13 Sep 2025 00:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8ABFCOY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A51B29CE1
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 00:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723619; cv=none; b=a+zTBd8AekT5/T8G0av4jJFr2FJxd8msymXGXiXN8/ihAAqX4PW09du3+WbDdxrh0OXUBS1neKK/JIgeyqIKdcvR8qQEu70wkpCPSeW6nIerCqSJC/PgNLYK2H9z8xaF0MuT3lMkDgtKYX2X7bE+3xi9VJx2R8KQR7aWPQYksgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723619; c=relaxed/simple;
	bh=6ixjMQGo+mF9rxxhZunX9VzR5bs0JXrtOuI72NkTM98=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pK1cJ/5JfVQRg6pbM4YgfdSB2/rtDgBcZUARPx3JUQvcVQWYy2RVHeRURf/ENkckfH3KTjp/Kn/4cqaeGkRSvfSQ20bWw2LfjZcDGsjQdqlujIktjT4uBuUXSSDl89t5gtCoWnIEwP43xAC/FknPm8ez0QDHr2G8B5qQnfcYZ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y8ABFCOY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757723617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncBfGy8EE17qYCVshxa8cc5ygoQQollWUOgPghVnN+8=;
	b=Y8ABFCOYGvmtliMGHQf+AXFx8kh07GGSmtGIbQ78d+T2Lcis3vOb2XAhVxtev7SyJURlCS
	JfZw1CRRwO8rpbKf/bLP1H/8GNRtYJrpfmGJ4oNvQVtlo3sjz4JAEvUki/mKIGVDR9jLDO
	rJeVuhvLxEyxyR/fniR/S8i1vfy6Lys=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-kzhvUTckMq6P1ndhoRXFpg-1; Fri, 12 Sep 2025 20:33:34 -0400
X-MC-Unique: kzhvUTckMq6P1ndhoRXFpg-1
X-Mimecast-MFC-AGG-ID: kzhvUTckMq6P1ndhoRXFpg_1757723614
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b32d323297so54052661cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 17:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757723614; x=1758328414;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncBfGy8EE17qYCVshxa8cc5ygoQQollWUOgPghVnN+8=;
        b=vyXxhwhrcCp0f5ek6kZmz/475T40RtOhfPaOa51Ug9tncXYrwmoagR9uF3u7UErX+C
         /9Um0EKg+kjGvghJzBiFCJk7l3+2hw+ulLPkRc6SlOYSf4PW8biBYKYbNOT/Y77CWyVK
         Dp6s5k05RBRmg8OeOU/CG0lCBWCJr70DW4kBnInRAQvYdwtaDYIAf9tbVBUv/eqqYDKu
         tU2wpUcksKFUUSBfRfC6/KaOoV+/D72lBRlvbON2L0Whnk0iQkxUj6gQV6CsDR6bLSv3
         pv9RSFgaL5iriZpeXE5LBJqwfwBQ0Bj/Wwj/p/eUIMnGDsYNxXpnrfTXTffwPQI696mf
         xzGw==
X-Forwarded-Encrypted: i=1; AJvYcCWK7nmYfj5+gM40xOwjKVNDGME1FAVLgQOBDiMQYpzatZs7LExYnjrYhDc5lhDs1N6GMwrq6yTNo32kuYcu@vger.kernel.org
X-Gm-Message-State: AOJu0YyLX71DQffHFEx+4RUtPeOmYanplCvwWlUHWJvHl4hi/EjOhl7c
	cO18tSwO69gQvoUiAcrtjGdJ7kTk2lP3lncekkytWmRg8aq5HH3QGvNJ8FbmOma/NDGlR5wpJLx
	/nKayLjszepYGbcSrYctwCcvmXXK5eNg005PcEAUanTBsoiyJSZ9XERiuRT3xYF5rf+E=
X-Gm-Gg: ASbGncsgSentFgpOhN+wtycwSpf9U/G83T6E4iWJUrOd7fh0PyFMaR1dusE5aWLMbER
	lbEz1op50vX6kZNUatNNHfuMtfNsTtuVgl9KULfoPwadBz2rMxYsWJzltxugiG+rFcmblTWhc66
	dR+dH43N+ZZ5fZjNVAJod19b8EQvYGdd//rC7CXuc3PZPutY9pBvz3/OljHWcgG/pFtuVl2hNtt
	s6BdFrUw9cuuPUNFrGCiJUceg4F5j7Zv44CCz4LEiijccYwiDveH/Zu3AMsSsKj6aLl/qGwX9oq
	z7vyd4afK72C34FyfnPXNxbQqLQlQWP+QWFGMt5wqi3idAFtNu7lcYlFwR9U5K7hzqbDc1cGF4U
	WPWxq/I5GHQ==
X-Received: by 2002:a05:622a:1a05:b0:4b6:2f52:5342 with SMTP id d75a77b69052e-4b77d1ab3a1mr68076221cf.79.1757723614301;
        Fri, 12 Sep 2025 17:33:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRq8wbBNQnbSCZtG/tvewoa9dvMcBJkb7MXthP0yviRVZ6G/ctSPGgxUCMnelFEMNwo4BLAw==
X-Received: by 2002:a05:622a:1a05:b0:4b6:2f52:5342 with SMTP id d75a77b69052e-4b77d1ab3a1mr68076091cf.79.1757723613947;
        Fri, 12 Sep 2025 17:33:33 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639b99de1sm31462791cf.8.2025.09.12.17.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:33:33 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9d06c0d5-e20c-4069-adca-68a2c4cf6f4f@redhat.com>
Date: Fri, 12 Sep 2025 20:33:31 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Remove redundant rcu_read_lock/unlock() in spin_lock
 critical sections
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Waiman Long <llong@redhat.com>
Cc: pengdonglin <dolinux.peng@gmail.com>, tj@kernel.org, tony.luck@intel.com,
 jani.nikula@linux.intel.com, ap420073@gmail.com, jv@jvosburgh.net,
 freude@linux.ibm.com, bcrl@kvack.org, trondmy@kernel.org, kees@kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-nfs@vger.kernel.org, linux-aio@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org,
 cgroups@vger.kernel.org, pengdonglin <pengdonglin@xiaomi.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
References: <20250912065050.460718-1-dolinux.peng@gmail.com>
 <6831b9fe-402f-40a6-84e6-b723dd006b90@redhat.com>
 <20250912213531.7-YeRBeD@linutronix.de>
Content-Language: en-US
In-Reply-To: <20250912213531.7-YeRBeD@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 5:35 PM, Sebastian Andrzej Siewior wrote:
> On 2025-09-12 17:13:09 [-0400], Waiman Long wrote:
>> On 9/12/25 2:50 AM, pengdonglin wrote:
>>> From: pengdonglin <pengdonglin@xiaomi.com>
>>>
>>> When CONFIG_PREEMPT_RT is disabled, spin_lock*() operations implicitly
>>> disable preemption, which provides RCU read-side protection. When
>>> CONFIG_PREEMPT_RT is enabled, spin_lock*() implementations internally
>>> manage RCU read-side critical sections.
>> I have some doubt about your claim that disabling preemption provides RCU
>> read-side protection. It is true for some flavors but probably not all. I do
>> know that disabling interrupt will provide RCU read-side protection. So for
>> spin_lock_irq*() calls, that is valid. I am not sure about spin_lock_bh(),
>> maybe it applies there too. we need some RCU people to confirm.
> The claim is valid since Paul merged the three flavours we had. Before
> that preempt_disable() (and disabling irqs) would match
> rcu_read_lock_sched(). rcu_read_lock() and rcu_read_lock_bh() were
> different in terms of grace period and clean up.
> So _now_ we could remove it if it makes things easier.

Thanks for the clarification.

In this case, I think the patch description should mention the commit 
that unify the 3 RCU flavors to make sure that this patch won't be 
accidentally backport'ed to an older kernel without the necessary 
prerequisite commit(s).

Cheers,
Longman


