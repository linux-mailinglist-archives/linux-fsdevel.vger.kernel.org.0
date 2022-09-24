Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB995E8EEB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 19:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiIXR11 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Sep 2022 13:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiIXR1Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Sep 2022 13:27:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0983F50728;
        Sat, 24 Sep 2022 10:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664040436;
        bh=PsRtpHdq4AT+CWVAymPqoiNsanBMnHU2fYO5pm+qHDo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=XcTGtFip54JZ8KRIXEQb0JbGFdAyUZO2p1jsjLiXgaHum+x+lH/hY2KfonISY1laM
         WFptxpCyMUxA4MxvYFSCUNKTVaiXnFUeIgQjNHgw38y81ROiKBAsnWkeXGqLtTt56T
         TZGoeesZ8Z54CM+nlr13KZBGn1lATMnc1lSfX/uI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.155.187]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAci-1p9GlH3xVo-00baxr; Sat, 24
 Sep 2022 19:27:16 +0200
Message-ID: <25baa8d9-4e97-870b-df9d-f558771769d0@gmx.de>
Date:   Sat, 24 Sep 2022 19:27:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH printk 11/18] printk: Convert console_drivers list to
 hlist
Content-Language: en-US
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-12-john.ogness@linutronix.de>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220924000454.3319186-12-john.ogness@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FaaQDdvUMzmkZo4RCwaKgj531JooyEgfozKQ4F+pHLLvOlfkxeF
 w1CaoAhrGEGfQvXAd6uVmmCmdFqedi+8suL9LM2ue32D49YEDKUBTnZdlZl6pDPA70DLe/i
 ALDWQiaZJ8lM3aO/HEG3XNVenSApK595yhsSoWiyYnzfllVcr+TxYS63/OrL25Yzl+58OuH
 FaG7Ja/BrELHN3is7AuLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bOUb49zcz+M=:DlRwfcFsq0YJtC4DtuaAjS
 d6DU8JVBdHbbWgS6LN64+yeJzHmDTfSAiS2fI7IizH3bipG9OtuPBz7bHRSDU2wFI6XNG7q8g
 7nESHu6ByYSrRQKxSp2Y2i3O/D1eWIX6mFHwrRE2OrDV6OBJ1S/76rz8xP6vCHe+AKJZzyfMB
 RZcx3trVqwM7VC/BvwhE7df8xL7jFlW70c9rOAusMVSEkkq6fBVtmabDwF4eWD6IR2WGIDO6/
 eWwV7pHVJLADkJrYizDZUNCHjTCdTNydhgnERR0L75/VrDPMdzxGCR3ppn4AQNV3H/Y4zK7Sd
 tqEMuTkPIzwZRMoZFa6R+SBlC8xOkRqVj05ZxydE6PnTjFwK/XHZIVT7jiqx4VX6TDfzHPSjM
 vCxyjOIj5OsSr9aVVuszSNKmdbkFuVpMX/iZa1C6LhI2TKv10jX1dZZdSqN5j4B93WvcfJ0lo
 4Msec6Xgeck7V6CtzpF0Z0Iy6aadl1IcTqUdg52Fjaeg1Bl6M7/IsiJQuAIR1dolA7xHD9QQO
 KpFMEuVqRw87VYm7gILeTW81iiBMc+Fi8PN5xBsCFH+Pojo6kYNy/J6oTuTD9xnVzDYBlJn7q
 oIE3+iq37OfPhJnzoKYeyPly27h2PsJ+K+BwJ5DkAub7nMJLM412ydETgAMqmRsnXNK3WXrJc
 hlQuy6fnT75D+yvFU33xCGyqZ2GIHUkpn9dX9Md2beHsQLM7Cmdm7I/0AmDXDbSHHQ5HkPyML
 0sMd17STwQFtUkPX4CtpOZ1r2vsD3e4oz7bvsCTlhX4C0YC0Rm7OWzwtDrzHYVZD32RBlAl9q
 xf4TjWh9w48UvKgi8dJoiojqlJOCqquejyr6beWhb5I9v6OdiqxK3P+J2TX4eiaL07lltc0bc
 hbjY9pGQWIQ7aV2XlatsuiHSxtsqvA0SaeTfu9yAH3dJ2R0EQYz5sp7jgZ4rAk9zcwQEwn8rG
 idAfYng5Lg4nSuGTJfL37ZTFzjE9vR+7DdVtjCzbg33HjUfIxAY38ndVg6FuH3mJIwrHAKewX
 dEssk4xju28d0q4YsSE/M0ygwHjgAEmE6j3VTVn/84sl/B+set2quOsWqZmavsAQHKrzqEYtd
 i6gvXBfR8F7FL8K47uu7ADEdCsi+kGdn6oiNeHFTEz6ZjOJOkLqyXKa2xU2zH0gAuQYVgSDdk
 hdrt19emaIsQZzRgXSoXqJsD3X
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/24/22 02:04, John Ogness wrote:
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -79,20 +79,20 @@ int oops_in_progress;
>   EXPORT_SYMBOL(oops_in_progress);
>
>   /*
> - * console_sem protects the console_drivers list, and also provides
> - * serialization for access to the entire console driver system.
> + * console_sem protects onsole_list, and also provides serialization fo=
r

Typo: missing the "c"
  onsole_list -> console_list

Helge
