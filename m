Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD00700EFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 20:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238257AbjELSkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 14:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbjELSkD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 14:40:03 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DC319BC
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 May 2023 11:39:52 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a950b982d4so533935ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 May 2023 11:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683916792; x=1686508792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LxNeqg6Grq2YNGnd0knd3lPwc/gWH4WprNL3yZRCSlc=;
        b=lp1Oy3BhdQeeC6JznyjC8cBtFOeNbflFpysHr1GQrN0z/RDcUwp19X8dIn53f44vUU
         H6iorDT8qheOoQg95Fu6GGi2b6yvR5MviYTnbz2V7XHJkGJBV6gsqCJRm3fqOkwHQAnH
         ShE6LHl4PKFR+g/210rb3bjvWRSlBMjSPomzjrvTXlqYyGud2RYS0DB1w/u6mJAlPq+K
         olPKd8cPOmPVrMHiWMXqvvY/x/JzSid+UfiuEo/l/PJ/cH5hyaZn+fgCcrSmxUbTqteB
         3DhYxfh+iVRcv3HeKAmRSVq6ZPJ0uU4rT9GO5+vLPcvHUBFo1aVN4GSNzLvp6Zs+3ojy
         s2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683916792; x=1686508792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxNeqg6Grq2YNGnd0knd3lPwc/gWH4WprNL3yZRCSlc=;
        b=Tc1vZurElUS5yuz3f6GCaO5DjgpgwJvqhkP9PcjRqmUWJYUSlnyTHJaP3VV76Kr9X9
         7s4pQeqqrhqFEHQ/cVECzuuk9dn9453S/RI/rUxvBSP2i+SHmjMYOvelo6G9PKnTpX+E
         BQMY0kaZyLmCr5xI/J903m1Cfuv4B7wn+xRGu624e7vuRGfHGjy+gMZJlnDuSO5kEW/r
         kIPBnCNiG6CD5bgc5wGZ5yGiLDGuWZ4md5Bg97olNBsntAIAHlPQq4MH8nfdThX1bsmo
         j/5god465SUZsNQniZmBvAbkuPgN9OVMSO6ggh46fHCcmmWNINDaDRDz0/GqpKSAr45K
         jimg==
X-Gm-Message-State: AC+VfDzpKSHHi+b/QRDlNuSaETYCG1N17m4XpM/UHj4We5RfbrRIxF+1
        LgkiQyLHjWbh+IVxkbXhwxNckw==
X-Google-Smtp-Source: ACHHUZ6aomZXGlc1Nc6ucUjpY7UMr453DjWUnt0izCabu5fBIrS8LJlevVdVes9dZNx3ZSW0bw23jQ==
X-Received: by 2002:a17:903:1cb:b0:1a6:6a2d:18f0 with SMTP id e11-20020a17090301cb00b001a66a2d18f0mr271059plh.9.1683916791741;
        Fri, 12 May 2023 11:39:51 -0700 (PDT)
Received: from google.com (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b001ac618a6d55sm8215718plx.242.2023.05.12.11.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 11:39:50 -0700 (PDT)
Date:   Fri, 12 May 2023 18:39:47 +0000
From:   Fangrui Song <maskray@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump, vmcore: Set p_align to 4 for PT_NOTE
Message-ID: <20230512183947.jvaslvmuhy7gndix@google.com>
References: <20230512022528.3430327-1-maskray@google.com>
 <202305121126.E5AD334AA3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202305121126.E5AD334AA3@keescook>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-05-12, Kees Cook wrote:
>On Fri, May 12, 2023 at 02:25:28AM +0000, Fangrui Song wrote:
>> Tools like readelf/llvm-readelf use p_align to parse a PT_NOTE program
>> header as an array of 4-byte entries or 8-byte entries. Currently, there
>> are workarounds[1] in place for Linux to treat p_align==0 as 4. However,
>> it would be more appropriate to set the correct alignment so that tools
>> do not have to rely on guesswork. FreeBSD coredumps set p_align to 4 as
>> well.
>>
>> [1]: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=82ed9683ec099d8205dc499ac84febc975235af6
>
>The interesting bit from here is:
>
>  /* NB: Some note sections may have alignment value of 0 or 1.  gABI
>     specifies that notes should be aligned to 4 bytes in 32-bit
>     objects and to 8 bytes in 64-bit objects.  As a Linux extension,
>     we also support 4 byte alignment in 64-bit objects.  If section
>     alignment is less than 4, we treate alignment as 4 bytes.   */
>  if (align < 4)
>    align = 4;
>  else if (align != 4 && align != 8)
>    {
>      warn (_("Corrupt note: alignment %ld, expecting 4 or 8\n"),
>           (long) align);
>      return FALSE;
>    }
>
>Should Linux use 8 for 64-bit processes to avoid the other special case?
>
>(And do we need to make some changes to make sure we are actually
>aligned?)
>
>-Kees

64-bit objects should use 8-byte entries and naturally the 8-byte alignment.
Unfortunately, many systems including Solaris, *BSD, and Linux use
4-byte entries for SHT_NOTE/PT_NOTE, and changing this will create
a large compatibility problem (see tcmalloc that I recently
updated[1])

Linux introduced 8-byte alignment note sections (.note.gnu.property) a
while ago, so the ecosystem has to deal with notes of mixed alignments.
The resolution is to use the note alignment to decide whether it should
be parsed as 4-byte entries or 8-byte entries.
I think that just setting `p_align = 4` on the kernel side should be
good enough:)

[1]:
https://github.com/google/tcmalloc/commit/c33cb2d8935002f8ba942028a1f0871d075345a1
