Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E9E212044
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 11:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgGBJqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 05:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgGBJqa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:46:30 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B70BC08C5C1;
        Thu,  2 Jul 2020 02:46:29 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c11so15633383lfh.8;
        Thu, 02 Jul 2020 02:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ziNTEH7a/u4WtxooTaLjfTLBlD+cFdaZkcpe66wJNrQ=;
        b=dCY4DxR83TkZUzSuEFKMdLgVxrtaCm7ny9MsL+C20yxSAbs40TUFGG5cn6gzNR04ri
         SAb6uN+xlYaV3BMCxvhEhpniQXlQIYkMJMnSvRCU/BZHtTA4c1mf4bhqGzMlDAfty/6l
         jjPUUEX++xSA3dbIcjb0duOyEd9rdaIxFSrYWA+bNgQK5lx5r6tMRuui3yjOuCgwwEz7
         BQbgh6Eh8AmxNiH+kSMZ6kJFM/tkvQKm8ANva9NpGRWxcmiwU3P+y4R9XQyVfI8uBPaw
         Cp7FS7VCg80XmfUdu6GF1ChaCJh7Bnk8Y/8K3Cfwybd2DKcfrEjpudPssCS2LHJUQs7f
         zHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ziNTEH7a/u4WtxooTaLjfTLBlD+cFdaZkcpe66wJNrQ=;
        b=t2ENDGSHz7CnNtRej1ibThKfEMWnYIKegUTf1hfEer0Mn7tLHHL9SWUtuMATKEG81/
         YGi76RFdWBgff59PpJblknVeyHXHImYV1We1nYKtvTVuXakIdAqP/RlTO6XF22BTD32c
         hVPMkKzmM9wCsSMI8OFtY4ftoCBmvkd8l3m84Hb4VnOjrcSY5Ekccu6pB+6i8ir+nSBg
         mSoK2VB5PJ49TrAlMRZKEnjmXqzJkoSzfZAx2ItX3n9wgppt2o02h5IjJmEKKMseiFl2
         ZIQvkHKdmfB036XPiMSUuXH8eqa8Anw0QEQf4lboHuWL4tw0WqK1HoubETz9eVhr+8El
         7Owg==
X-Gm-Message-State: AOAM532grnU6doxwMGAR7JZwdn6ab9crEhylQaKL2WgrKmiX0TIoPAlx
        JlLG/eIkKtpCtzTNcjd9NoKyVbSQHvEQlQQBFow=
X-Google-Smtp-Source: ABdhPJxfK4BDsZqz4Aifp6YcuY0H9tlI5VdJFUkNhexgbBdZ61vRE9kzltWFWhH/qBpO6UYfYH5xChvVItl1/PlQC2c=
X-Received: by 2002:ac2:46f0:: with SMTP id q16mr17941299lfo.51.1593683188191;
 Thu, 02 Jul 2020 02:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200701200951.3603160-1-hch@lst.de> <20200701200951.3603160-17-hch@lst.de>
In-Reply-To: <20200701200951.3603160-17-hch@lst.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 2 Jul 2020 11:46:17 +0200
Message-ID: <CANiq72=CaKKzXSayH9bRpzMkU2zyHGLA4a-XqTH--_mpTvO7ZQ@mail.gmail.com>
Subject: Re: [PATCH 16/23] seq_file: switch over direct seq_read method calls
 to seq_read_iter
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Wed, Jul 1, 2020 at 10:25 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Switch over all instances used directly as methods using these sed
> expressions:
>
> sed -i -e 's/\.read\(\s*=\s*\)seq_read/\.read_iter\1seq_read_iter/g'
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nit: the replacements don't take into account the spaces/tabs needed
to align the designated initializers.

Cheers,
Miguel
