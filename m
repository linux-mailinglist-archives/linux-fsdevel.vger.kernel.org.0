Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E43768FD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 10:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjGaIPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 04:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjGaIPO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:15:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3684B2113;
        Mon, 31 Jul 2023 01:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690791173; x=1691395973; i=quwenruo.btrfs@gmx.com;
 bh=M2f82U5hVBJa6GZa3MFNkRMNtrM7JQCovxt4mKThYGQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=kHsWiquxL0SD0cySDLZ3+jgphRK9FsqaKML5krXcy3xuiN9mQiBToHJVLGstCyglwOYyS+V
 UelloiXsN6qMt9jvwoTtBT69yqvaehDPbxyZJOkaU/T5pEXGYi+Fp1b5922PQfqhUKv0LRx+B
 xPYGwRtXAaQGFQEMCqGcX0y+YlgBoNyRtXrh4k2VXyl1U5SDwLNy6/dz4WYXUHaifNWhfoaZH
 uXc9+FVQmSdq/D+EvlCGbGWGDRzfA9VR4Aa6SmlMincAbmx35hj1WQxgaccj7A3tFtdTA8SvZ
 tdzF5WCaghqwVwiAPjU8+TBHwxMuu6wwADX8K2UBujIfYpqw1dQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHG8m-1qdZJc3mdM-00DDJa; Mon, 31
 Jul 2023 10:12:53 +0200
Message-ID: <358fab94-4eaa-4977-dd69-fc39810f18e0@gmx.com>
Date:   Mon, 31 Jul 2023 16:12:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [syzbot] [btrfs?] kernel BUG in prepare_to_merge
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, johannes.thumshirn@wdc.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000a3d67705ff730522@google.com>
 <000000000000f2ca8f0601bef9ca@google.com> <20230731073707.GA31980@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230731073707.GA31980@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yR50Ar70zKfcSob3aC8m8Fb/fdjetGtk7o5inwIPBzebU6xpxof
 A+LgSl44rarsxw/hRJX9W7wxsq+VX1qpgifxLaZdM2C8HGEpkV3dZfXvdYgIgTAbiitLrUE
 h0OeK0xQPfRc0ON2pdkX93DrGX95wQNRI2nFw/t424leRVTN3yf0DuZyvPtcJ70/JoGlEmX
 i7Z0QMvpOJmA6hUMNuVPA==
UI-OutboundReport: notjunk:1;M01:P0:FXZJRcocu0E=;V3PTPbpkrgtr46GMvs2qvNpVIlW
 UYG0yXI0P6ogW8e3pVgsOm1EfDKpcQc5iUU5dCeaV0dLt2DhOEm29vRsSBf9vhy0ARMWYHfoJ
 rcpCBcYn/pUY3Skf6WMqKcdzxwlH029VEzDeXHylWJqzAVjoGfoYSdfYZ1Vk9vgCf8FGaTRm2
 lV6OQCDUc4v1zXG2EPOoZDE1DqDNiv3NzYES3QDw9+iKbCrkHNUXESrvCEAIgTVptaNz/cTN+
 in+d4FN5/uE8LWOJh7m2xPzVYt9pN8gG1wEpAaDPl0gS8sj8C+oKyV2H8oVoNKT1dc9KkSzwE
 8KKiWHZ+rIa1Vgk/E3eLRT9uYzdAbF8+NStTXG1XYzq5r5/Yexl0ggmf3Q2yrNVzV3E03Gewk
 LU45J0wTd9aoQPQttk7ogmPl6gthxAPr9wQEggGIqCYwWI+p57kzB0NqV7QXen7RrDqCP6ib8
 AF3CzQuc7ylRGTvbSIE9LN8F4u2/cs7iPNwN9xmJz5lJMsVNGFiYbh7Ox3b3hqNqSO2WTicWS
 HJA6ujrrHEg4HACu/rzBizOoQQDmcOpWaz6zAjvJg5gbZszmdWzjTPkqiCww6xMZ90hU66epP
 9JaPlvx8MHUHV5h56UdpH7RrGwxLzjzdGbfqx9itTj8BC39GG2Wu6c4c3foQw2IlPM48k+MD2
 3DcQQPexVhqAt08kIHIryVK6UZCOdnKnK9oqnSvaAOvXZEAsBjtQoQmkUrh6WyssbxdjWgDv/
 YpuWtGjgk10vZoPkphhn6Ar2+tGyrudJ1iW9+wDcvCFDITif4sadyXVDcC3d3XMwg2XYXaLeB
 gyOUw6zPkP3wSXkFlKdGqFi9jR1lUbsqJmUytVqJKhygP6i1Hihg2U6e4OHLA/GGji/ojzFgf
 oJ7ZoIaVoW5yO3lbgReFAklWTmhzoHvodEZI+9yY+GUWDdSyQDJpvO/zak2OIqG7eizdqu1q7
 c0qpOYT+YYXcCg8tOMV+8IlIWF8=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/7/31 15:37, Christoph Hellwig wrote:
> Hmm, this seems to be missing the usual C reproducer?
>
It has one in the original report:

 > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14dd3f31a80=
000

Thanks,
Qu
