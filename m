Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0D25166E66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 05:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgBUETm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 23:19:42 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44176 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbgBUETm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 23:19:42 -0500
Received: by mail-qt1-f196.google.com with SMTP id j23so393131qtr.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2020 20:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=jR+bcPiDsug87G22T3m75d03tbxYdln+pR8aYjajd+4=;
        b=DMUfLkmoWwY7Oen9tGr4KystEUnaEeq09VO0b6IloNA1i4L1y4z5QiBty8yLLiJl+z
         yNUHWlktuMullZOs5k5Tq7xYy7cEs1b2JSdOmpwEzRShPGl2qOwdCkTwJzIBSO3Lwk0l
         22p6zc3l/5yEZXnL6+yJ+Wdp6GRQ9rC3m615Re8S7WyyRvTa5TUxatNwR05kSZDgn4T0
         iMcSnYCkkWgu16yoJJCkL6Pnw6XY/HMsXu4vJ2tuo2AIOiFoYWIdexFCOMQ6G92sqswf
         /Hb4v9ObkoFPMM+J2Z9p3m7Rc4BzoeC+Ej8jxvzhHUTCXPxn0wG+7gLOfjQKSerueQyu
         SiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=jR+bcPiDsug87G22T3m75d03tbxYdln+pR8aYjajd+4=;
        b=gW/YN/eFC+m1RPhiJ41XPRtWUFnkIgC17EPZalnRXDwbYjGsvDWx03WSG5CWQjtlwM
         BYKtiiUtVterahVjUiAPUrKe3LJ/M8ww2e/czpI+0zz9wisOsbBrWrduh5wZ74FNFdpD
         lpaYWFO+LiW2BydjTRhzws8+QNW+eZcYwuBVVzO1uFnIfssteXZAPFHPZWOpZyL+9NEw
         GHktrCa67HtdCA30mie37UPnWQkqD2/idSGT6fruS8QvJL0iLlsGW0omFfCChW9J/2+O
         mvNH394/5YUTkHzPd7A/ni1T8Ognj7TVUEJNZDtdf8Dk5RX+zu/QKyO/DQBalGQOHoL2
         gW6w==
X-Gm-Message-State: APjAAAUp5n/nKGA+ByYJUVLV7CIyR9D0iuuD19Fx57qrCNeCYpgal4kq
        WfMxiedf8qTJoT4Y2ZhvqYEOHg==
X-Google-Smtp-Source: APXvYqz86G10lqygxIpng+OwtWH5WIdgO6o9B7vkFsK2yXRRy/kbL6ba3fG6yH5n6nY1dlclIKG8EA==
X-Received: by 2002:aed:2d67:: with SMTP id h94mr29295311qtd.74.1582258780516;
        Thu, 20 Feb 2020 20:19:40 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y91sm975458qtd.13.2020.02.20.20.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 20:19:39 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] fs: fix a data race in i_size_write/i_size_read
Date:   Thu, 20 Feb 2020 23:19:39 -0500
Message-Id: <7351A815-AA56-45FC-B15F-38F81F140253@lca.pw>
References: <CANpmjNM=+y-OwKjtsjsEkwPjpHXpt7ywaE48JyiND6dKt=Vf1Q@mail.gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CANpmjNM=+y-OwKjtsjsEkwPjpHXpt7ywaE48JyiND6dKt=Vf1Q@mail.gmail.com>
To:     Marco Elver <elver@google.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Feb 19, 2020, at 4:21 AM, Marco Elver <elver@google.com> wrote:
> 
> Let's assume the WRITE_ONCE can be dropped.
> 
> The load is a different story. While load tearing may not be an issue,
> it's more likely that other optimizations can break the code. For
> example load fusing can break code that expects repeated loads in a
> loop. E.g. I found these uses of i_size_read in loops:
> 
> git grep -E '(for|while) \(.*i_size_read'
> fs/ocfs2/dir.c: while (ctx->pos < i_size_read(inode)) {
> fs/ocfs2/dir.c:                 for (i = 0; i < i_size_read(inode) &&
> i < offset; ) {
> fs/ocfs2/dir.c: while (ctx->pos < i_size_read(inode)) {
> fs/ocfs2/dir.c:         while (ctx->pos < i_size_read(inode)
> fs/squashfs/dir.c:      while (length < i_size_read(inode)) {
> fs/squashfs/namei.c:    while (length < i_size_read(dir)) {
> 
> Can i_size writes happen concurrently, and if so will these break if
> the compiler decides to just do i_size_read's load once, and keep the
> result in a register?

Al, is it more acceptable to add READ_ONCE() only then?
