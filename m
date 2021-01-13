Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA142F549E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 22:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbhAMVfY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 16:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbhAMVdV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 16:33:21 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AEEC061575;
        Wed, 13 Jan 2021 13:32:34 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a12so3642083wrv.8;
        Wed, 13 Jan 2021 13:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C1D6OpS9nOPNTAL661gj0FTLgnooIvfmNmJpQrvYYu4=;
        b=sAvodikFz3mZ5/hcI7jeCBI8awd8Gkp0GiUMiP+09PgZZxw02S6hf1FgcEEErDOM/7
         aNSy3GCfaX63RMZX7Twwv1YVJJC6n+Gvyn3Q2RF7Y+LUUQ1a9JkqGa26ZfN28RhjoqAS
         7ez94e1YpL23VHtx2h0stkOtVPdOHO0ym9caNvivJa3sbXYdmy2IWgZqoV1nVZG91b8C
         kWYZBd7Q35LS4d65GpJ0lHFmQMUBJO1IPGDN9lz63TYgFLjeZMquX/gVaidmPEIT66nB
         1B4gHOA5UJYK82OZ9jW9x4k4Uzx6I8mQS42oqYLreoEpyFSpXVJhdWDpCY2u7Kpv4LeU
         uI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C1D6OpS9nOPNTAL661gj0FTLgnooIvfmNmJpQrvYYu4=;
        b=WfJsF93XoNqRPBzNpGvwwe5U4zoHJX1vA+OK4TYJFX1nNfOUATtH4rRcnkJ9oRlF4K
         zvdMukFL6BIwnXQDI1T+TuAhP8ryRRavLEjFrWzA2VluLy3LIdgeu3vdZrAeetIMDJvg
         X9gFngIp6ivcYyRPUFhldV5C9er0wywYNnp1Hv4MdB7i9YyQLlRGMHiRvPt+sjFWekST
         QEZ7svcFyBh9DxehCOmrv4hJa93GbjH6umig5K2lRNWwvVUZpsZcb/Lf8GzXEgYoNg4P
         xxc+l31SjOWqsBdGJ1xS1R5wtifSAm+5Vd5vYsQ8+fn5rQuFuiMlHhhol/0vEyRnL6T9
         jEpQ==
X-Gm-Message-State: AOAM532yK0wyscoaQ1IP5GQ1xuvLhEO2rmkfM4VC1jrJWVm3K3Z58SUn
        OAnHXePN88KA/vSqSex2F6bb8cySAqJV
X-Google-Smtp-Source: ABdhPJxejBKLOdOYyBIpfYUFYrR3sDgd0L+xQ1H5YUT12NuT2bl9AOPjtNbycKQ8qhH91wPhGP9nCQ==
X-Received: by 2002:adf:ce84:: with SMTP id r4mr4485117wrn.91.1610573553740;
        Wed, 13 Jan 2021 13:32:33 -0800 (PST)
Received: from localhost.localdomain ([46.53.249.51])
        by smtp.gmail.com with ESMTPSA id r7sm4630108wmh.2.2021.01.13.13.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 13:32:33 -0800 (PST)
Date:   Thu, 14 Jan 2021 00:32:30 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Piotr Figiel <figiel@google.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, posk@google.com,
        kyurtsever@google.com, ckennelly@google.com, pjt@google.com
Subject: Re: [PATCH] fs/proc: Expose RSEQ configuration
Message-ID: <20210113213230.GA488607@localhost.localdomain>
References: <20210113174127.2500051-1-figiel@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210113174127.2500051-1-figiel@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 13, 2021 at 06:41:27PM +0100, Piotr Figiel wrote:
> For userspace checkpoint and restore (C/R) some way of getting process
> state containing RSEQ configuration is needed.

> +	seq_printf(m, "0x%llx 0x%x\n", (uint64_t)task->rseq, task->rseq_sig);

%llx is too much on 32-bit. "%tx %x" is better (or even %08x)
