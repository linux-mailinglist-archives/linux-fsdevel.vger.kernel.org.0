Return-Path: <linux-fsdevel+bounces-3434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F146F7F48C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 15:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF8E1C20B4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 14:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5A44D5BE;
	Wed, 22 Nov 2023 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jiDqKR32"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E6110
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 06:19:27 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5caf387f2aaso29952367b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 06:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700662766; x=1701267566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dUuXue76CXuXMitsPHyW7Zcj/6p9bLqIblRtzrqhwvQ=;
        b=jiDqKR325AsSVTS8DzN/wwQi/NeIYgSKsysg+L7A3hQqDuHs+TNnxofD5L9q4Y0HpS
         8lKCybw3PcFCyw3OuNBNma/cpIzeyTqX7GVSneE1SNOt1wn6Ss1GXdvlIL6V99yBqDBg
         0AxCd1pS4ntqxaY4LdZwjl6tJwpFvmaSpT0qtdFmM6iiXzSsx/TQeTFzAfbsp8dJsdFr
         5HYNxP8d0vaC8qQLCB3BNy9VdbDIpCRpQgeLQhrrOBAKN2eKxgMsSB/56s4R/+HazfTd
         wGUdQ+Y0VuAm8J04T6TaRam6oHG5WlN9IsASAXeRh4rwER9XXIVzcL4S2n4MuN8FbQhA
         gfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662766; x=1701267566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUuXue76CXuXMitsPHyW7Zcj/6p9bLqIblRtzrqhwvQ=;
        b=m7R4LxsPG46l4RHLPLSMySKzbIeXqrsJjd0Q4j26Tb9oJqLqZRkJ9Y4t+J5sVP9ByI
         eUxVAT7DGVhzXdKD40lOu21hT1k6j8BkuAr6+13n6Ft74B1dcVYaMas7xeDhyk0nNrWj
         2Yo25Q60t17mt9gOiR9PtI9zGicoDElnfm/9ccGkWLYkonJ+UBwBuo70BYjID3zMAlo8
         c/m4/IU5fYURgy0NYTPV51BOJ6dokZ4PHj/w5qOcvLbEuhIYdXmpEgTxPSXGfLOlReCG
         hUA3eo9Fi21lzqhV8BE05pfEcJ4susn9n2Iy46ehgc1jFzufxy0yiwpJBFAFMNYTJr7L
         6/QQ==
X-Gm-Message-State: AOJu0YxQbRo2CuzhauAEbWrfGCGMAk+7/9jYpqGDBI37w6uZLjv/Y7UI
	ufkCiTNW7cE8e4Qk9GYnQOtzyw==
X-Google-Smtp-Source: AGHT+IErqs/PN+B9z67h2+4TqPZfdz2AvdCCefan27RDVwGuCmaVTVlK/X6QugZrb3WlD40MFx4ijQ==
X-Received: by 2002:a81:8742:0:b0:5cc:c00:8d73 with SMTP id x63-20020a818742000000b005cc0c008d73mr2293819ywf.45.1700662766313;
        Wed, 22 Nov 2023 06:19:26 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id k68-20020a0dc847000000b005a7dd6b7eefsm3704869ywd.66.2023.11.22.06.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:19:25 -0800 (PST)
Date: Wed, 22 Nov 2023 09:19:25 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/4] eventfs: Some more minor fixes
Message-ID: <20231122141925.GE1733890@perftesting>
References: <20231121231003.516999942@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121231003.516999942@goodmis.org>

On Tue, Nov 21, 2023 at 06:10:03PM -0500, Steven Rostedt wrote:
> Mark Rutland reported some crashes from the latest eventfs updates.
> This fixes most of them.
> 
> He still has one splat that he can trigger but I can not. Still looking
> into that.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

