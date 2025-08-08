Return-Path: <linux-fsdevel+bounces-57031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D91EB1E2BC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 09:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2E76279E0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 07:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFDC224B06;
	Fri,  8 Aug 2025 07:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H8OuczV5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C5A218ACC
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 07:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754636442; cv=none; b=YGFtjlIA0Sof7lLJu9Bj7ESIomnG9bdQ868JHjKjAdjYeK8QUwOqH6FkOYxaX2UYcy5Yzff76L1zYFF3fHUdq0PKRz7ZEgcLSRWms5K4JL7mQqJDVB2ls+S0OcImV8skLpdP32gXtN7KuekXtHQfZVHL4I2fGSc8U8tlvHDCueA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754636442; c=relaxed/simple;
	bh=EVo3hfbeuPKUpx3HiKtclFoPoJrpFgA+aUM1ynHlZmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFN51PGuNfEc2oVFwXvQ/aBIPBbb06G1jrS7E74kUtGXsSRiyBNjNmTdDPSd8//JevQDW4IpsXVSk8wivSXZ89Fi6UeogSAPu5d39Bf9jhJD44HbINKnUMZNpBfrwU1iVlK33b4K2fQa6fg8kp1Dx++k47OBa4uwQlOXUNMzIuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H8OuczV5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b786421e36so881903f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 00:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754636439; x=1755241239; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pVEu9GErkIXG3eJ2AqWu2ENhgTXDL/O6jQUo/mg7Ei4=;
        b=H8OuczV5c2frY8nzSZfjozNjQ6w5McLU6qpHfli22/7R/gH9ZJffDgFSAwkH0+JjIL
         1iWydbr4N2KJpvZD0JVYbQuhXLIyEt4zT1BGgA11CL8zmPpqX4q2qvXOWy3FSSZ3AKuU
         ntBuWJebiX+Je7fDRJG2ARR89Pzk/pHc5HwUmZapdJz2gEBySjbzEoZPXBbYVR6SfVoC
         JETKaS6SlvSvvwssKfNDTBYgU+SrqM/RnrwuQxWHJXH76R2DBTpOYYm6v4LgMq5TZyHg
         2yzSgPC8ZDyBMWKK8I9v+WZPIANkVLFG3MqFx2W8S0RqAK6HU31+BgSzwQhUzRblSV0G
         xJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754636439; x=1755241239;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVEu9GErkIXG3eJ2AqWu2ENhgTXDL/O6jQUo/mg7Ei4=;
        b=FxosTkNXCsp29Fn49s0Z8BHgOGQKdjhYIpqIVbRJ/guJINTuI06xNikShkLXCdKWsW
         L9/hFOm9druGa5QNyBa3WDZ1fmLrbinNtpRt72D5cYiuuWSz3dGer76jtuGh2y4i9nGz
         RcfbvxX7TVb9KQn3Mdprie8XVHJ0riRhyPi7p/JXXkcA38RVsQTHPHEIEWkJswGyj6iW
         W9mKbdjVlIgUMvIk8zeA1y7RyWfTMljPxo0V11tD3gfC/OGw05yjmTfJ2LwWqEzCuPna
         stKIrfjDNU37uRCJHRjNhY3piXkEt6089pHSyzM5TCdDoyssEjvKR0LHkJWOfkYIN3eD
         HyoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1Yl8jULDh+W0dhDDEkZhFdaQd1M7tUM0lUiwNk8fVVBf2qgAsacObeiQQtQanb9svaRV+glAmYUgtwuLq@vger.kernel.org
X-Gm-Message-State: AOJu0YzSthqM+J2+qPTUwXIDPC2vsq1hKcwsK6cBo7OgjogKol3JlM+x
	ZrrjnhmXisxmvE0JmMPoJIsgOyLQ3LUj6lFFwEOc10LdXJHmZZ2akVa54GWbUYmhfd8=
X-Gm-Gg: ASbGncsQEABPWz/ZE7zRSO7nWKzFizeE0Mk1P4Ct3w/ZdV5sFb8NzK8FEbBl6YdNzHi
	cMfgs0IL/dsMVFSfmOBrFFSGnk2BJa06AWuX6gA2hCqKXnUVXoiufTEKH8bU4hiwOrCpH+5XBnp
	Ce3LUNZuaQ9UFxV4AmgmnHNXrwvmOFMsyG4teI2yg7PuRuiIsWZ19qio7ZByfe2khIi7LOj8OIR
	Q9dyWOPkr00oL5MSZkIfN8Yi3VqOCASwMAnhEiEYnN49lXVsyJwHlbeEb08KmYyFsiuk3XeOumz
	t05TLYzrYyV7hAYaDyvUcxMmPwcejPEuwrLEH+sYT1tqnONMo/RE80AzU4xjMaMpl1Xg3P5HH3w
	vMl4anbKP4D9xaKG7mvMsufX4yZ85eyloFu4=
X-Google-Smtp-Source: AGHT+IEJk4yevy9+HAy0KW8ZE8r8h3He+ydCFV/7Q/AXZWGxTkl97mbZhRDgapiuoxoRlq32dlvmJQ==
X-Received: by 2002:a05:6000:400b:b0:3b7:7cb5:a539 with SMTP id ffacd0b85a97d-3b900b2baa8mr1256578f8f.18.1754636438515;
        Fri, 08 Aug 2025 00:00:38 -0700 (PDT)
Received: from localhost (109-81-80-221.rct.o2.cz. [109.81.80.221])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e586a011sm133293865e9.19.2025.08.08.00.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 00:00:38 -0700 (PDT)
Date: Fri, 8 Aug 2025 09:00:37 +0200
From: Michal Hocko <mhocko@suse.com>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	len brown <len.brown@intel.com>, pavel machek <pavel@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nico Pache <npache@redhat.com>, xu xin <xu.xin16@zte.com.cn>,
	wangfushuai <wangfushuai@baidu.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Adrian Ratiu <adrian.ratiu@collabora.com>, linux-pm@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/9] freezer: Introduce freeze priority model to
 address process dependency issues
Message-ID: <aJWglTo1xpXXEqEM@tiehlicka>
References: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
 <aJSpTpB9_jijiO6m@tiehlicka>
 <4c46250f-eb0f-4e12-8951-89431c195b46@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c46250f-eb0f-4e12-8951-89431c195b46@kylinos.cn>

On Fri 08-08-25 09:13:30, Zihuan Zhang wrote:
[...]
> However, in practice, we’ve observed cases where tasks appear stuck in
> uninterruptible sleep (D state) during the freeze phase  — and thus cannot
> respond to signals or enter the refrigerator. These tasks are technically
> TASK_FREEZABLE, but due to the nature of their sleep state, they don’t
> freeze promptly, and may require multiple retry rounds, or cause the entire
> suspend to fail.

Right, but that is an inherent problem of the freezer implemenatation.
It is not really clear to me how priorities or layers improve on that.
Could you please elaborate on that?
-- 
Michal Hocko
SUSE Labs

