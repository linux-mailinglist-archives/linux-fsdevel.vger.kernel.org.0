Return-Path: <linux-fsdevel+bounces-20870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476D98FA5DB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 00:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACA928A928
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 22:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D9613D268;
	Mon,  3 Jun 2024 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GlLbdUhx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE5D13CFB5
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454321; cv=none; b=M+5Nt5yWiHSEPC0y2/VZew4zq6cxEVD39TRTyxezxSpdC8/KIk1CB3wp76gPnTUwgkY1xbekCTFHBkL4EHtzrO0WIGCHucBRCGlgt07DnIKyDMz5z06WKB54Ymr7Y1NhcCtxvEuh1ht9gbVlzky727Ymclx+HiVg5HErLaYdh1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454321; c=relaxed/simple;
	bh=ADQ686y0LUmppB8hKb1UqpO0JQXUA06qEhc0vs+CvAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1NvGvvHn4H4umGs29xu2SVf7h5g3sUjHrnzPdz2ggtYStp1r4AipWMLrqarbhbPPe9bOIVJlQjcYbI6gSpBDAW2y9G6gGF6TzuLKdiG5dJnR/PGSSKhrleWO3H6jlYGQ8lXKfkcM52Nxo+ZODLRYHC/hC4chfvak507Ea6lcnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GlLbdUhx; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5295e488248so5125995e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jun 2024 15:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717454318; x=1718059118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6K+BGd/sjVibNL1YxWnASTBR3LzmvEWN/LqVUKBH3Cg=;
        b=GlLbdUhxMOvfv07UbuQp52IzwdbLEpzUyMLKXMF+3Sd3FveyGQ9kiponRzzOcpMI6T
         emqgoJVIwu8WT9FqW+p07vqBAyXhgq+fwevyFcKUJiULsxWdobvwl8b48coCz7mCa9oe
         PdXEK+mV0+PmDWLF5beeySzOz0sai6fZmW68U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717454318; x=1718059118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6K+BGd/sjVibNL1YxWnASTBR3LzmvEWN/LqVUKBH3Cg=;
        b=dmmp3HfH1PeJ7belEGMlU/PnLnwtXLbOoHQ9egc/N/za7rwRVhmfiFqlLz2VKm6cGU
         F8R7xiN6LLyDeSLnC5TCz/QiByia+6GYn4bsCKMe/aTq6/9DBUg6lhBZY4QrPuR5yQRP
         Nhzy16RLVjyxrNtyoYSVcbISwDerNlD/AcxPZCf7bWIUPlJQb9XXQzbU7ZfVAKRto+yS
         2MlToO3zIuz0dBlpBEcSAmWvXwIBNayQjUCCqrzT67s9HAwLbx5sm3jwdnDv0yVN2I/Y
         u39U7BgvfvS8px7eoWTa6bHgETU+QVrrV8je/bsdO/4vhrMRo3TzQC4E5Kh2iPxJS8fc
         lCmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjT4+cv9Xdqf69Vhq5sq7y1WhL/HqXVA12Qa8FW/ZFR/4303gSbBhV/kgTwHzt4JsO4JUXt9mK9yZ5RETRy0DslEDN8S0sFTUBLTrOAg==
X-Gm-Message-State: AOJu0YxCrSEPGQKFDU+XjlFvLQbtqYk/DD3nr7lVDNrxh+ndrHEejAJ6
	hjHUO7WmgSfIfexco+iHLsckZAjSPKDXt3HipXsp6Vj0Ux8trrPopSOzGo2gc3DBAJScYjcrXiQ
	C1F9sYw==
X-Google-Smtp-Source: AGHT+IEu+9Va36dt4hEL7zvQvUDdlqFiE87Civj8d9FQAsznB0eIK9v+fqVBivTxTryHA4jLKoz6Jg==
X-Received: by 2002:a19:7403:0:b0:52b:3d6:67a1 with SMTP id 2adb3069b0e04-52b896c4a8bmr5594393e87.43.1717454318127;
        Mon, 03 Jun 2024 15:38:38 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d87624sm1325699e87.241.2024.06.03.15.38.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 15:38:37 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b938587a4so2445192e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jun 2024 15:38:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvKBLQ2JR9tQczBQ1P5yeakBfZ8YQLO47CJsqQkbRmWYY70JLo5S6oDAqhUU8S2Au/Yfp854BHXEHtguZMDiO5WwlmcHJPWj6+mk2Ytg==
X-Received: by 2002:a05:6512:159a:b0:52b:9f37:3ec2 with SMTP id
 2adb3069b0e04-52b9f373f5fmr1374809e87.11.1717454316895; Mon, 03 Jun 2024
 15:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-3-laoar.shao@gmail.com>
 <20240603172008.19ba98ff@gandalf.local.home> <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
 <20240603181943.09a539aa@gandalf.local.home> <CAHk-=wgDWUpz2LG5KEztbg-S87N9GjPf5Tv2CVFbxKJJ0uwfSQ@mail.gmail.com>
 <20240603183742.17b34bc3@gandalf.local.home>
In-Reply-To: <20240603183742.17b34bc3@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jun 2024 15:38:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4WVUkXD1LMz2jFf9eY=p83SWSM0b4rcP34SshkgFoxw@mail.gmail.com>
Message-ID: <CAHk-=wg4WVUkXD1LMz2jFf9eY=p83SWSM0b4rcP34SshkgFoxw@mail.gmail.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 15:36, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> It's actually a 4 byte meta data that holds it.

Ok, much better.

> Note, I've been wanting to get rid of the hard coded TASK_COMM_LEN from the
> events for a while. As I mentioned before, the only reason the memcpy exists
> is because it was added before the __string() logic was. Then it became
> somewhat of a habit to do that for everything that referenced task->comm. :-/

Ok, as long as it's an actual improvement, then ack.

            Linus

