Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7226F503341
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Apr 2022 07:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiDPE20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Apr 2022 00:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiDPE2Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Apr 2022 00:28:24 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C906B26112
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Apr 2022 21:25:53 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s14so8468365plk.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Apr 2022 21:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwjZWUK23SDc9f6Fzho9lbrW12rtjQaU86s3X7g7WA8=;
        b=F34psi04KzHnYMusfXO0+Sf3dJ+pbADOBfrHzkAjvESdbhKsZSm2ygbl4eJ8nzig2M
         6I4LRslXFzO0BGeOnKyUp9HRJeF5QPCuHXGQNSY4rw5MVk8II4OdX1w478l05XQxHCaj
         ltrcULTumO2g2mcppqt0GiQ9OCt++92abzFh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwjZWUK23SDc9f6Fzho9lbrW12rtjQaU86s3X7g7WA8=;
        b=NFX3VPO5udrgk3+3BPWNvMpKQRHxytXSg6J8R84erZ+QIMt15XtxlIhRoyAtMJwP++
         91yFLiuGvpPagKO75sn7hWmPrpFafT1OUGQHxKgFeHSkEeDX2i+8u2xFgVy3ScIUkxJK
         VX2rEC46EyIOqTFskj0T/dJKadkNO/PHSVItNbyJpsEw4nmVnCN0fgJU8WwY8JDM3ifI
         FznyhGBM+BVRyk4Z286MCYOjT4q0Q3x+E7rMTZfepg2jCav/qqxOSC0JwaNlXUcfcVRt
         6JSF7UMjhQugO+pxUli9Y6gWrR3vvB+1hGdFsi8+m+fE4W1MmpYkabFa0mS77UgGiZj2
         +TuQ==
X-Gm-Message-State: AOAM532Ar3mYhr0rIQBXHdZqbxNcjGFbrL/IrgEO23coSusmx1ynnEs1
        BfsudwlQtp7Zc3nUoFcVkmI82A==
X-Google-Smtp-Source: ABdhPJzuch/i5PtXeUfpilPZbG0Ojdf8xS0zPST9o6TFZXb4i9S7hdqyz7HtmT5xcBIsyArbi7vBqw==
X-Received: by 2002:a17:90b:4f91:b0:1cd:3a73:3a5d with SMTP id qe17-20020a17090b4f9100b001cd3a733a5dmr2216377pjb.98.1650083153061;
        Fri, 15 Apr 2022 21:25:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h5-20020a17090a648500b001cd5137217fsm6115627pjj.47.2022.04.15.21.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 21:25:52 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     palmer@dabbelt.com, Al Viro <viro@zeniv.linux.org.uk>,
        ebiederm@xmission.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, niklas.cassel@wdc.com
Cc:     Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
        vapier@gentoo.org, gerg@linux-m68k.org, linux-mm@kvack.org,
        stable@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] binfmt_flat: do not stop relocating GOT entries prematurely on riscv
Date:   Fri, 15 Apr 2022 21:25:07 -0700
Message-Id: <165008310452.2715005.9013061971753495821.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220414091018.896737-1-niklas.cassel@wdc.com>
References: <20220414091018.896737-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 14 Apr 2022 11:10:18 +0200, Niklas Cassel wrote:
> bFLT binaries are usually created using elf2flt.
> 
> The linker script used by elf2flt has defined the .data section like the
> following for the last 19 years:
> 
> .data : {
> 	_sdata = . ;
> 	__data_start = . ;
> 	data_start = . ;
> 	*(.got.plt)
> 	*(.got)
> 	FILL(0) ;
> 	. = ALIGN(0x20) ;
> 	LONG(-1)
> 	. = ALIGN(0x20) ;
> 	...
> }
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] binfmt_flat: do not stop relocating GOT entries prematurely on riscv
      https://git.kernel.org/kees/c/a767e6fd68d2

-- 
Kees Cook

