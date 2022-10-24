Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF70F6099BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 07:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJXFYD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 01:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJXFYC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 01:24:02 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7E37AC23
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Oct 2022 22:24:01 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b11so1200117pjp.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Oct 2022 22:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yU5BVsJ8MPC4nvdZWcT2dJ2yYF9IwPhzGzbU2K3Mj8k=;
        b=Ssel1FF8vXDAeZ1m+o8/xKO5E78OETuFXhriwQZ7tfmpuxkdCjpPe3SFkrgZkRGWb0
         R6DVm4rL+fQMBgQpX/DXv6i3wIcY261HmaNzsttfdOnBYvfhAXMojQzj1Vf7zhtFSvQN
         snSKPB+Vuw/rOGhQsdYHY0yXLdlhgITOgKS3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yU5BVsJ8MPC4nvdZWcT2dJ2yYF9IwPhzGzbU2K3Mj8k=;
        b=BA1SvRNlUkwdlc1vD19KgPR98ZL+VQvBY6qLjbej/6ydPKp5fQxRLwsFFSa1cMIU8V
         RnMPZaQnw+MFGnT8GuK0xivWLTdR6xFt6lUpDDAZlcV6k7sPELf7wk1Ci9CGyn1eOa4m
         J2KkzTl91kcLz+/Ih+ftNfka+xgjlvn/7QwDHXRc8iSD1Q+0Wzs1g6NALH/h1lCGejfg
         i1Zq/4e2Fedg0sCgu7ftkbpm/e50FUvivSIbAQAi0hrR4vkDW5Q4ENAEfiicsTIiFzjm
         tM+JYLuC9I/jg1BKUfpH1pMFzZHqfRODbsvj3M+t3Gg+UbAfUzkAXphcJOlTf4GsczEB
         xBXw==
X-Gm-Message-State: ACrzQf0IWp1gd/OSU+UXtkAT5ti42AEm8/rAC6cXEyysBTbJVJn1Q7A3
        +YHzv584wqd9+M/9cPP7cJ3k2Q==
X-Google-Smtp-Source: AMsMyM6x6sSHrtlAwrfNBkmXx6onldTZw6Uf2b/twPyfKoxRw/el1ZRujgDu1ZPiWuNJkxI+qXemYQ==
X-Received: by 2002:a17:902:be03:b0:178:6f5d:e979 with SMTP id r3-20020a170902be0300b001786f5de979mr31608752pls.163.1666589041034;
        Sun, 23 Oct 2022 22:24:01 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:7f0e:f6a4:8d85:37e4])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902cf0300b001785fa792f4sm18857930plg.243.2022.10.23.22.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 22:24:00 -0700 (PDT)
Date:   Mon, 24 Oct 2022 14:23:56 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk v2 02/38] printk: Convert console_drivers list to
 hlist
Message-ID: <Y1YhbPb07tqiX0g5@google.com>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-3-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On (22/10/19 17:01), John Ogness wrote:
> Replace the open coded single linked list with a hlist so a conversion
> to SRCU protected list walks can reuse the existing primitives.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
