Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43D6F1AA3A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2019 06:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfELEMQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 May 2019 00:12:16 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39413 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfELEMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 May 2019 00:12:15 -0400
Received: by mail-oi1-f194.google.com with SMTP id v2so3715458oie.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2019 21:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zJ70OMmVoSATwQY41e9CXbzi4KY/zdWtiMcMVM3Rwn8=;
        b=qU7Hwxn3IxhowOOfu6iETyWGYZ8uOWfxuuJuPTlmL+Y03uBkhDUwgp5bUKfrX/epWo
         0uww+l5p/OJ8Z4Ih/GofL/hTS4N6CFyXva8Cw+THf7cRng8DBNDnknXZVkSgD/VCtNN6
         Ib2SNx1i1Lf3l8B55YnzhcUXLzMUKfaps9/FMIBo36Qn/Q2KdhfvKi3hND8n6m5SQnM8
         lDpAWVA4AJyuBfKTvjV3vFKRtu62eysICpVmEnKYNlK43xBzSH5evomPGQGUU3c5ks4p
         3Lq/W3QCCg2HPCN5iG70FeC1ww0vMcsAEYEGJ6XnpLO+E7AAq4u1sE6TNEmiZcQ/tL5x
         NhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zJ70OMmVoSATwQY41e9CXbzi4KY/zdWtiMcMVM3Rwn8=;
        b=rHpADrOYtxqaIeXvlwoPF+HfFWhYvRZ23aTB6tzFxf/z/3W5g/j7erGoOXCxKzck9K
         ewow8WySzn1LWYgO07p1ix1zir3YdnNbKAX3iNbLmGGQTn8m1iVNsV1pPWE0HJXPL9o4
         oNiy9UjLSPWO/zmvVDmk0cTsvJiHF/7s5m5Jt9UbKI2aBnQVV+8l0PD4tE6v1lFdhifK
         rdPI1xeNPGJ8ymRjDqaAvVp6UtFKMt7nPruZvgMEjxZuERD5D3j9SZXAViGNCkBqqFct
         uzdEiIuQr0nKz/3Zgk79PmfkyTpT7b1bbmuKy5k60QJgr/UoFx9bP4FPX7jrkTHhhKYX
         AZhg==
X-Gm-Message-State: APjAAAXI0u7z/gYCXZgR9nm38D/reYKxwTOLhoxHkfYqe9+bzG487rEE
        Y44uQbYzcxwNosI9tS7IyGqPrA==
X-Google-Smtp-Source: APXvYqwsz1sNEYQulaiAcNJtkVRe/vEPL7OP4OCFtAhzvdsHDEjbLD4uem3wP21mCcmLHlq8eNmslg==
X-Received: by 2002:aca:3093:: with SMTP id w141mr10501165oiw.173.1557634334937;
        Sat, 11 May 2019 21:12:14 -0700 (PDT)
Received: from [192.168.1.5] (072-182-052-210.res.spectrum.com. [72.182.52.210])
        by smtp.googlemail.com with ESMTPSA id t7sm3206053otq.16.2019.05.11.21.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 21:12:14 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
From:   Rob Landley <rob@landley.net>
To:     Andy Lutomirski <luto@kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        initramfs@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        james.w.mcmechan@gmail.com
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
 <CALCETrXy7gqmmy37=nrMAisGadZ+qbjZjXtWFF8Crq86xNpsfA@mail.gmail.com>
 <4aee6e10-0eec-1d76-af66-dc8c7b68b766@landley.net>
Message-ID: <c2b6e4d1-10a8-6ff7-44c9-55fe10fc7bb3@landley.net>
Date:   Sat, 11 May 2019 23:12:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4aee6e10-0eec-1d76-af66-dc8c7b68b766@landley.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/19 11:04 PM, Rob Landley wrote:
> P.P.S. Sadly, if you want an actually standardized standard format where
> implementations adhere to the standard: IETF RFC 1991 was published in 1996 and

Nope, darn it, checked my notes and that wasn't it. I thought zip had an RFC,
it's just zlib, deflate, and gzip, and that's not the number of any of them.

I still think sticking with a lightly modified cpio makes the most sense,
just... in band signalling that _doesn't_ solve the y2038 problem, the file size
limit, or address sparse files seems kinda silly.

Rob
