Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4ACF7BE852
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 19:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbjJIRhS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 13:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbjJIRhR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:37:17 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F061B7
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 10:37:15 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3af5fd13004so3492541b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Oct 2023 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696873034; x=1697477834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zd3O1eB/Wpq6g0qSptggykfHJXEZdAtkErQAM+wkdIU=;
        b=anlnOJEI8gxsbsxEVxg1Mpy3Vub2+WKe/ddw7GMm+yldNcDIpUVHhWgrSKhmpNAEs6
         2pDtcDrhX/a7/AUEJsPh8xSeuMf8twxh0kD5AljLOQEqjXt7vhZlnKyestyRBxMDgD9/
         6H+CbSm1VePOBvTAPYF7JYyoAtXprFPbxWYOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696873034; x=1697477834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zd3O1eB/Wpq6g0qSptggykfHJXEZdAtkErQAM+wkdIU=;
        b=bhVk53kDrG9wO7lbMaGeughnR80NQDdXXemohRwF0jvbDAAsNKrTDTDqdLK63C3Nmh
         j4H8N2NxEs9kkh9Mw3wHLS2VbWgSntawk9Xvl+ncs2n8wBTQffGNeFu5X5WSlMURk2Fv
         UMDhwT5ydGsmgwSDaUAwnbp1F8cKJtGlFF4ZKutWWDuhTxlg149OJlhE2fs5nIjdwS3u
         wBrKVLXOghmu6BWRX/qHXwIm7mGP8S3JF336evX6h6vYGlhJ/xa8I8u4SppBm4mHchKP
         zzTi0WHiiP8fhHj9HPJZ2MeFId+i7zzBST5I5rdANyjBEJ8VvZznZJHSpKihlLdYojlQ
         oxfw==
X-Gm-Message-State: AOJu0YwrzsF/Q12mQUJKT7MW/ihFVqaEcAS6YlZN4kd7ilSDfl8Jz54p
        6nCtuK6lN4IsyNi3gAcXHlFApQ==
X-Google-Smtp-Source: AGHT+IGu8KBpPELECSJVM0YYzq3jws78WVViT8o+27geAQZlCLJCe8lEhxuGAZR5GU32WI+llpg5kA==
X-Received: by 2002:a05:6358:88f:b0:135:47e8:76e2 with SMTP id m15-20020a056358088f00b0013547e876e2mr20101688rwj.4.1696873034345;
        Mon, 09 Oct 2023 10:37:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b7-20020a17090a6ac700b0027768125e24sm10306606pjm.39.2023.10.09.10.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 10:37:13 -0700 (PDT)
Date:   Mon, 9 Oct 2023 10:37:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, ebiederm@xmission.com,
        oleg@redhat.com, yzaikin@google.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, willy@infradead.org, dave@stgolabs.net,
        sonicadvance1@gmail.com, joshua@froggi.es
Subject: Re: [RFC PATCH 0/2] Introduce a way to expose the interpreted file
 with binfmt_misc
Message-ID: <202310091034.4F58841@keescook>
References: <20230907204256.3700336-1-gpiccoli@igalia.com>
 <e673d8d6-bfa8-be30-d1c1-fe09b5f811e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e673d8d6-bfa8-be30-d1c1-fe09b5f811e3@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 06, 2023 at 02:07:16PM +0200, David Hildenbrand wrote:
> On 07.09.23 22:24, Guilherme G. Piccoli wrote:
> > Currently the kernel provides a symlink to the executable binary, in the
> > form of procfs file exe_file (/proc/self/exe_file for example). But what
> > happens in interpreted scenarios (like binfmt_misc) is that such link
> > always points to the *interpreter*. For cases of Linux binary emulators,
> > like FEX [0] for example, it's then necessary to somehow mask that and
> > emulate the true binary path.
> 
> I'm absolutely no expert on that, but I'm wondering if, instead of modifying
> exe_file and adding an interpreter file, you'd want to leave exe_file alone
> and instead provide an easier way to obtain the interpreted file.
> 
> Can you maybe describe why modifying exe_file is desired (about which
> consumers are we worrying? ) and what exactly FEX does to handle that (how
> does it mask that?).
> 
> So a bit more background on the challenges without this change would be
> appreciated.

Yeah, it sounds like you're dealing with a process that examines
/proc/self/exe_file for itself only to find the binfmt_misc interpreter
when it was run via binfmt_misc?

What actually breaks? Or rather, why does the process to examine
exe_file? I'm just trying to see if there are other solutions here that
would avoid creating an ambiguous interface...

-- 
Kees Cook
