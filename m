Return-Path: <linux-fsdevel+bounces-16420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B01C389D50B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 11:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D45B1F224CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 09:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33077EF14;
	Tue,  9 Apr 2024 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpQFxEST"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA497E78B
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653338; cv=none; b=aB2FN6TWQk8JKum6xQ0cVGWQqTqqHwa0ULzzj6/xG2gofSc7lO18CCUGh73bQfRRbPoqQwkQhW93HlYeOiUxrryLeKKI2+rg0y0MdU5wW6CiQXxFwS+LkgkPd8Cp9ipUW6DBO1wH4AqfN/iUDULOF1AFJEWxNmqErnyQ/WWW6c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653338; c=relaxed/simple;
	bh=euhpq35wFK9rmemS5feCCQzrNuJRo+rAgFPHnTkC0AQ=;
	h=From:To:Cc:Subject:In-Reply-To:MIME-Version:Content-Type:
	 References:Date:Message-ID; b=BroD4Dp/fyBif9vl+omwd8HXpHzRESDDZC9Lg0x7P1qUAJD5hUl41Q8YcNv8pmj2vDv77QN5zDJQsowzWC68SBkjAl7oFL32LAJ24AT23Nz1UfPDI6p54+x4oj+ArM7D+ns7T3T25p7yyDJQ2sqycdMMQZHJqs4WcwBFP12vbis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KpQFxEST; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712653335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=euhpq35wFK9rmemS5feCCQzrNuJRo+rAgFPHnTkC0AQ=;
	b=KpQFxEST1MCnVLCSyly/XAxCsNUpnTs2CPXMKqFo4q83hy1A0QgReJY/wklwqGYqFDeuyE
	MTEKNSii8HspAk6j3HdSc1M4c69DgXbbajeFMpTa4X2/iPR8EZ8C6gCpyaYmLELklgOg+Y
	rdw4WryVTm5KOVY4B3+vge7HWWS7oUA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-R8X2iX65PdKgaL9fQL6Cgg-1; Tue, 09 Apr 2024 05:02:14 -0400
X-MC-Unique: R8X2iX65PdKgaL9fQL6Cgg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78d3352237cso770250185a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 02:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712653333; x=1713258133;
        h=message-id:date:references:mime-version:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euhpq35wFK9rmemS5feCCQzrNuJRo+rAgFPHnTkC0AQ=;
        b=UCUz7uKSkhctSHlMHckzfudIhvI8DUBMRwb7Kq/txVAh1JQTSP+fmT1QLp0ITvspnA
         qVowcK4UzW9+U+q01nezRck8KKsNSYXhYyfw5Py5yuU+rS+DfnjYIrNHhI3kYOjdIWlZ
         VTmsCmdplnqKOf0Q63AN0pCUAP+fe2J1JE6dDuF2MsoluROHtJ5PSx1dF1f2ZwMFDMrf
         O7futFC7vcJ14RornF9Vw6edyfnyhgPe5bcFVGqOi9lTlNilTAy+v5l+I401ZuEemnyq
         FV3bo9oyM/kfu5s8c16NAhG9YMdHFvRNLeI06uk+AXm+gD+/qGYJHqJKuU/5k0y295zg
         bqYg==
X-Forwarded-Encrypted: i=1; AJvYcCXC96zFuHaHxq9z3hS1RhV8H4sF3Ozkv3WN2btIiWpfKz7ypKdrH9ksiEFvEPK6a4Rwi2e1re9lUdxMItUBWAKVcUJm4bHOBMVfRLEnMw==
X-Gm-Message-State: AOJu0YzftIUNtvnbJ+2NSi2KcjEicYsv9jmhow6jLeRde6GOcn7xhETD
	kehJHT5cM7sC+mddJlzWp9gKyl2x0YU9v+gBTfDq+ANXYzMPKNbSH456zZRnDVHeCcz0ly8gLIc
	gL5hDLO+6y8BC7jw3NZeCvNqygRUQ1OKU7UKlvKRYrrxPCfuDq9/D5Wg4armszxM=
X-Received: by 2002:a05:620a:198e:b0:78b:b0c2:17b6 with SMTP id bm14-20020a05620a198e00b0078bb0c217b6mr3047961qkb.11.1712653333495;
        Tue, 09 Apr 2024 02:02:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfJ9YI9fXu3bzCu+1ZKDrEFWqdCINgH4B4WK2Fj7Lg7ZxEGYh8Q7hvW22usdjnP1/pni2urA==
X-Received: by 2002:a05:620a:198e:b0:78b:b0c2:17b6 with SMTP id bm14-20020a05620a198e00b0078bb0c217b6mr3047929qkb.11.1712653333008;
        Tue, 09 Apr 2024 02:02:13 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id h6-20020ac85486000000b004347d76f43csm2678126qtq.79.2024.04.09.02.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 02:02:12 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, josh@joshtriplett.org, Kees Cook
 <keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>, Iurii
 Zaikin <yzaikin@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Petr
 Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Balbir Singh <bsingharora@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH v3 06/10] scheduler: Remove the now superfluous sentinel
 elements from ctl_table array
In-Reply-To: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-6-285d273912fe@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
References: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>
 <20240328-jag-sysctl_remove_empty_elem_kernel-v3-6-285d273912fe@samsung.com>
Date: Tue, 09 Apr 2024 11:02:04 +0200
Message-ID: <xhsmhil0qaoz7.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On 28/03/24 16:44, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
>
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
>
> rm sentinel element from ctl_table arrays
>
> Acked-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>

Tested-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> Signed-off-by: Joel Granados <j.granados@samsung.com>


