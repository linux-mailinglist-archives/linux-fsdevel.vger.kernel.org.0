Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE3B7A467E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 12:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240883AbjIRKAW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 06:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241056AbjIRJ76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:59:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52DAEA;
        Mon, 18 Sep 2023 02:59:51 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ad810be221so563289766b.2;
        Mon, 18 Sep 2023 02:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695031190; x=1695635990; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bHJH3dyMC9XQ0B/wqpE6xWX7DIRsvVcIcXhdiXVsMlo=;
        b=L8oNNV1NX9q3zsO0Qtfp+Bz/Hb0UuIpEq0jR2wty7RmPyzubbJgFpkR9TrXWCTmnr9
         X5GrVEwkEiLXJ2jmb6QOKMbkKQnsveMvcrq8V0g1FwgT5d9L1Y0dFVVuIQkjM5h3lvLM
         TYhCcb1j/hLRz9X0f35pQcTJYw57u3MF0wNYcVeVg7K0+tVnng5vBnzUsxRijwzQA3Sz
         Y12RhrUf5AT8ru2UG7CdIAMNV2lT3qaBQ1Nn8+QiSfvh0+DWi5d7sYu9yKNtoaHXrHfU
         imSK6J/2JLRNPZuAFjeMZpPrTs/tXzDuov+U/g+FXeAy1VTWFUY2SW9yO+556PwNiZ0x
         MP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695031190; x=1695635990;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHJH3dyMC9XQ0B/wqpE6xWX7DIRsvVcIcXhdiXVsMlo=;
        b=Ud8YVpgHTS8g13LrFSmiq7Dp8k6FpPSHapDMhIfA10uvgJg0wbXOF2crBsL8vgGGQ6
         E5nq1tniHg8RvG1j2wHkPpXmgAAhfg1hvIzgEn9cuVYXT6NgcaTxfzRWBSdV0pNrDmm9
         7LT60iRf0KEtVHUf4NyMNkdFqmD+EscNKoAnOm2Hw9EKoObfxiRNkR+G20Yi488vKXZN
         fj7vUgoAqCZ3sG7+Z+VsRujcsuhbVlz7WsBzw8OlEgt/Alb/IbCdWoq/Qda5BtnH9rhV
         vtXG1yNBTpCr70cPZf3uzQHtnfiYqu9orvRhx3lvvnpY1fyK4GmutGd88oYXrPDLfTzG
         RXuA==
X-Gm-Message-State: AOJu0Yw7ETCxTO1LhMeeJnYBWHY+FzF58dttBa+KsaS6SV335K80207N
        0XXnNiRRk5DY69N/YLiiUFeRc+rZCw==
X-Google-Smtp-Source: AGHT+IHBExGEci+f4wi9PnJLlfYXcD+QOl7K8LaZ2rmVI/NBv6q/oICF64GGgnXv+/wRJGvou7AdAA==
X-Received: by 2002:a17:906:300e:b0:9a1:cdf1:ba3 with SMTP id 14-20020a170906300e00b009a1cdf10ba3mr8373766ejz.27.1695031189942;
        Mon, 18 Sep 2023 02:59:49 -0700 (PDT)
Received: from p183 ([46.53.249.126])
        by smtp.gmail.com with ESMTPSA id vb1-20020a170907d04100b009adca8ada31sm5038695ejc.12.2023.09.18.02.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 02:59:49 -0700 (PDT)
Date:   Mon, 18 Sep 2023 12:59:47 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     =?utf-8?B?5byg5a2Q5YuLKFpoYW5nIFppeHVuKQ==?= <zhangzixun1@oppo.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: DoS in lseek inodes with proc_ops
Message-ID: <fe27461f-69ef-41aa-bc8c-6e3fbb7f67ee@p183>
References: <SEZPR02MB70394C03FD07798864962C7C8EFBA@SEZPR02MB7039.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SEZPR02MB70394C03FD07798864962C7C8EFBA@SEZPR02MB7039.apcprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 07:39:51AM +0000, 张子勋(Zhang Zixun) wrote:
> Hi,
> There is a null pointer dereference DoS issue when I use lseek syscall to inode with proc_ops.
> I find the root cause is https://lore.kernel.org/all/YFYX0Bzwxlc7aBa%2F@localhost.localdomain/ .
> In this patch, the lseek syscall is set to mandatory. So, if proc_lseek is not set in proc_ops, pde->proc_ops->proc_lseek will get a null pointer.
> I want to know why all inode in proc need to set its own lseek, and why set default_llseek in pde_lseek isn’t a good idea?
> By the way, although every inode need set a lseek to use lseek syscall, lseek to a inode without lseek should get a fail return and the kernel should’t panic.

It removes 1 branch and make code smaller too.
You can switch to nonseekable_open() if you don't need lseeks.
