Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A14700ECA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 20:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbjELS3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 14:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238604AbjELS3J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 14:29:09 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB227ECC
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 May 2023 11:28:40 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64384274895so7373712b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 May 2023 11:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683916057; x=1686508057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wu7QjxyIEj8Ln0iJ7kC1lictfM5N8E9aPqKarxQcnRo=;
        b=mVWTZPifMoHLSVHy4Y+TkqiPsN5TBnj8pw9/akxIyVJwOmHNbjAXiei7xFChDHXtk8
         UgPD+eFo5yiRVXIvsSrzHmLZIk2wgtMCVBQ1a/ieZOm9+IZsNleOG3Z7r8tcxmqaNcH9
         HCGBf2lqfK0w6tZ7WND306xHjlXb0gbgfi1gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683916057; x=1686508057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wu7QjxyIEj8Ln0iJ7kC1lictfM5N8E9aPqKarxQcnRo=;
        b=RNrqHNc0+gtVf//MYynS69Upq6uz6RLloJlWJTL/a4uzTDTfxaG4eKvuO2pONxT7MF
         7M/HCJfBj8aZTzvKAkoLSMZbsffK5wHsnJN/Pqlqs2/qRSp/Kb1FEepqKH1NdurY3duL
         HHbWxi7cZ75f64UiVTLFCtWsvonOSd29OlWSRtDApF6FAqrofk8d8nyKmnYtl4AhbGi3
         3DNHfJhxT3nW20vR1cAC+dIIJS5nkKYnL3LkwDM01NNXxz3Kxg6BNTq/sZQh9YTPQxuf
         214c4mh2y8ho/SnBjWVNUbwdxwrw/GpAb8GEBRKHzssTQQ82zF5m5jXb5FM2Zo94GjhL
         SSpg==
X-Gm-Message-State: AC+VfDzZ/orBD7jtwVUVnY58zTLczMVRrumveT50W1G9S6fvlYND+qEc
        DqgEkdlQFGXym7q3XnW6yZYfPw==
X-Google-Smtp-Source: ACHHUZ7p/urZKZskQu20+A4odA3ca2trpKf9+C2kVlEdDBeyGa5r+sUN4pDeYAbVnf/yzpt4mWqLyA==
X-Received: by 2002:a05:6a00:1703:b0:644:c365:50d5 with SMTP id h3-20020a056a00170300b00644c36550d5mr30144377pfc.6.1683916057299;
        Fri, 12 May 2023 11:27:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bm17-20020a056a00321100b0062e0515f020sm7328051pfb.162.2023.05.12.11.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 11:27:36 -0700 (PDT)
Date:   Fri, 12 May 2023 11:27:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump, vmcore: Set p_align to 4 for PT_NOTE
Message-ID: <202305121126.E5AD334AA3@keescook>
References: <20230512022528.3430327-1-maskray@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512022528.3430327-1-maskray@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 12, 2023 at 02:25:28AM +0000, Fangrui Song wrote:
> Tools like readelf/llvm-readelf use p_align to parse a PT_NOTE program
> header as an array of 4-byte entries or 8-byte entries. Currently, there
> are workarounds[1] in place for Linux to treat p_align==0 as 4. However,
> it would be more appropriate to set the correct alignment so that tools
> do not have to rely on guesswork. FreeBSD coredumps set p_align to 4 as
> well.
>
> [1]: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=82ed9683ec099d8205dc499ac84febc975235af6

The interesting bit from here is:

  /* NB: Some note sections may have alignment value of 0 or 1.  gABI
     specifies that notes should be aligned to 4 bytes in 32-bit
     objects and to 8 bytes in 64-bit objects.  As a Linux extension,
     we also support 4 byte alignment in 64-bit objects.  If section
     alignment is less than 4, we treate alignment as 4 bytes.   */
  if (align < 4)
    align = 4;
  else if (align != 4 && align != 8)
    {
      warn (_("Corrupt note: alignment %ld, expecting 4 or 8\n"),
           (long) align);
      return FALSE;
    }

Should Linux use 8 for 64-bit processes to avoid the other special case?

(And do we need to make some changes to make sure we are actually
aligned?)

-Kees

-- 
Kees Cook
