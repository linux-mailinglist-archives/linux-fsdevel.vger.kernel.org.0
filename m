Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC7F1044F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 21:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfKTUY3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 15:24:29 -0500
Received: from mout.web.de ([212.227.15.4]:52167 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfKTUY3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574281284;
        bh=YldMlQYtvURKq5OvbfriqKmy+salNat+YCBh07nFwRI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QOu54pjOra0yalxiceexthtvoPUvdVhEcaFI7FqIAH5YAW70N0vGHAyieCeYRX3vX
         BbR3/OmK7vaW+Pk1adnfaw4CYMbjJL0isJM1BMLiMj7qokKZyakYhpR6sfg1vN3eUM
         jYndeschg03sgIFI1uN6+TUpk82j1I7+9sXeZTB4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.176.80]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEEdU-1ie78G014y-00FRSZ; Wed, 20
 Nov 2019 21:21:24 +0100
Subject: Re: [PATCH v3 01/13] exfat: add in-memory and on-disk structures and
 headers
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <20191119093718.3501-1-namjae.jeon@samsung.com>
 <CGME20191119094020epcas1p26de9d7e4e2ab8ad5d6ecaf23e2dfdca8@epcas1p2.samsung.com>
 <20191119093718.3501-2-namjae.jeon@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <30222888-e62e-494e-269e-cb1a0746a01f@web.de>
Date:   Wed, 20 Nov 2019 21:21:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191119093718.3501-2-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TPFMwv/LIzMI7d1BZMW+ORUEGJoSLAxTt1lFcrfKflOLL+j2dNd
 SZN/bsnt24XMuT3Kf7hWRCViJsi+yzJl8AWNO0g4TmwCJIUoCziM5Dv12xu3bbhR2aNkkdP
 VESwj4rQO4l7lXn3IxaXOhU4GQLdHokelbEjAsQEWhdtDFivbH9f8+aIk8rmCT2e5thBoRl
 ff5w8kezk3rzZUH4IvDXQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pO5NPiQ3Cr8=:r2fhtc33Ht//mIXKUczz81
 gL9qXQimmuPBhWNYAKc3hlowMguYsyBJwoGJeNlXcEVkQs0RNyBskEslDeM6SnpBX49L9KxMT
 HTgTzqgUAJjr3vxRj8rcMK7lddvneOjqRc+TkFW1FPdJgSlyK3wS3ixyr4mFs/MLOdbwwXZry
 aeYYa8GF1m/MQ8kJQVAKrdJ6GwohqKyc8DwWXyQxGvNvgX9Zrs5hqRWzID/YxZBYXoBpOYaO4
 Jgp0dTqV9SrpZALBGqw9W4eHtuh5/W6DpE/ICiP88RHfsvcxi7jeqV2yM5d/q+6PCvPdeHZTg
 e2w/za+e7Pxlz5GibeVJ13ZNnIwc11Qi0rwE/G+wBzS8yK1lPVu5aYAkmOmaIAUxfrQEv0uxc
 PHLfccBCjt0EyIGieiIEApMuWL/Kg+a4W3mrP0oTJuLCe3AsLPR6RDvsPb44kn9M6e2SRu1UG
 g9Ck3Ud4Kvg7hhd2Kfwhp6we9fWVoW7fKneSydBI2KC7nQQYxPJsLh/66sdrwtxxOjVld++2M
 7RyrnYvQtMPntPe3/pYCQhhN9UjdDXQa9Q6cQZnT7hAETxnirCHna+Zti0ZrFWyzx/pWVhQ+9
 kXgeZbw9BkpB8UkvMFUtfcVh5/k60H55j99uGjaar0PGuFYtGaey1VtaIF/XZUxjSv4zwR5Hb
 F63ij6VtO5nLghl/p92BfbKhbiPgb2uSffZjzlhAGdEVLLm6gkR0y0ILz4FkouubwpZpmSMNY
 LCTJoMtSCM6u/R3IqbsZ2603sI/v+r+Xh4oQSEYt8exYg3GpaGzIMCYQcgDDFo0Rnb6nVv84g
 EiaY3p3zLvGJSBGOqtVtfjdZZ/oSb/6bxwk55wBVsfdN25pS6vGdL3xhNzmvb51uJpj1scU/8
 JqYF8vQs1YIDzd38w3WJIf7OvDSIHgrws8gFeoiOp383Ijb55NIPVkVqGaXtKfPelH0TJlld4
 HqlD4jU7LezQ/pUJ6oW4D/nM4GW92ezUz0GLFLT+3i4pJMteYz216mIL0rmyiR47Gg+xxWRBS
 zJaIlB24Noe0oV0d3EHsVcd+BqFS6Spdi9rbXvQj22OmPMgv04N95GCIuthNM+6sUSpTLW8ni
 ANFQaInLYHeCI7u8B9d8T9RgYfMsdY+/J28+MvCiar0MpzzPfYPcDOeRy3gyQZTVJEuzEX2RW
 VtWJbVeiDtZNqd9tV8hYPgZ04wPD961uL1OTQF1dUs9xgtGTZZR3FAJfV9YH3nkaZeha1aAUV
 7q4NOIaEZvF4JqERVRmRT9sE6csAsl17D5j3n1szKT3nAHuNn+k/d9eLD7y0=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/exfat_fs.h
=E2=80=A6
> +/* balloc.c */
> +int exfat_load_bitmap(struct super_block *sb);
=E2=80=A6

Such function declarations were grouped according to the mentioned
source file.
How do you think about to include them from separate header files
for the desired programming interface?

Regards,
Markus
