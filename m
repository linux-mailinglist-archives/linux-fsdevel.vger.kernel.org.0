Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F313115628
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 18:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfLFRJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 12:09:30 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37189 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfLFRJa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 12:09:30 -0500
Received: by mail-lj1-f196.google.com with SMTP id u17so8436413lja.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2019 09:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7EbNmyL2KBbFhAf+WiEp2SlV2yCcET3pLh6OrmQkbQk=;
        b=Usv+fNnnCb+9+t8soSUIa534OoCYo0jCIPfkhJ5fpyMtj7KNU8ABV2MUp6O+CW516U
         eeRzaucwrImDjco1O4HE9VvR8Aa5vs9mbqFaUseSt8JFxFRf972YBIqqxL+SN+SMXw9e
         p5kFppqcReC4TI2kp1OGprlBQ3hrwerx5g4oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7EbNmyL2KBbFhAf+WiEp2SlV2yCcET3pLh6OrmQkbQk=;
        b=bFZ3L5OnpyAQsGx04AhKFejUFaNIBg7MosGfsMCVD5oeH/XXXFTsPtTcosfN0XznJ3
         hMKEM8tp+QZdDOzLPksvTX2Skn/YCPciZ1hPQIM3eoEYvHjOcHQoso02AafdGal31Q/X
         Hn/0/QyLoCZYEGRsaR3Ng4G+prW7C5gav2YpHbWO3VQnA7J307lGTzARz8QwLOBomIHu
         tDohiQAAS9qbLBkqMP+BD87rinjqV+885y9zLV2u5BxtYVVhl0QzEbLZzsa4+qY4wF2X
         Crsl06N25shuJc6nu+ljx7DI9tr3v8J8+6bV2gRHCr/DnHIkYyv/xafu6RpxLstDRwog
         5BLg==
X-Gm-Message-State: APjAAAUay+vOj5GsOqVTk5HupLgWqWIFaXX/D0XyqWOdtvwny2Tu20JN
        2IWBduvc7fw4wFUgOPl7Qf6l5D8xYDk=
X-Google-Smtp-Source: APXvYqyvYaU4CTLlYWCKHP2/kGh0U10ni4C6cTD4rNTy2vjDOpAv5g9YbPhrJ3C9EsjX/CVCbI3yWw==
X-Received: by 2002:a2e:1f12:: with SMTP id f18mr9036696ljf.11.1575652168514;
        Fri, 06 Dec 2019 09:09:28 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id a27sm6775977lfo.38.2019.12.06.09.09.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 09:09:27 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id h23so8409081ljc.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2019 09:09:27 -0800 (PST)
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr6932025ljg.82.1575652166847;
 Fri, 06 Dec 2019 09:09:26 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz>
In-Reply-To: <20191206135604.GB2734@twin.jikos.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 09:09:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj42ROD+dj1Nix=X7Raa9YjLfXykFczy0BkMqAXsFeLVA@mail.gmail.com>
Message-ID: <CAHk-=wj42ROD+dj1Nix=X7Raa9YjLfXykFczy0BkMqAXsFeLVA@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 6, 2019 at 5:56 AM David Sterba <dsterba@suse.cz> wrote:
>
> For reference, I've retested current master (b0d4beaa5a4b7d), that
> incldes the 2 pipe fixes, the test still hangs.

Yeah, they are the same fixes that you already tested, just slightly
reworded (and with a WARN_ON actually removed, but you never hit that
one).

Does the btrfs test that fails actually require a btrfs filesystem?

               Linus
