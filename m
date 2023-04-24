Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6587C6EC4FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 07:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjDXFoQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 01:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjDXFoO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:44:14 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9381892;
        Sun, 23 Apr 2023 22:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Content-Type:From:Mime-Version:Subject:Date:
        Message-Id; bh=/Y8OPyk4aNbiy3q/w0nr6wCvbfpL9Xvjt2hU8ucCgiM=; b=l
        CY6fYiPhxQsTbDJoH459A7BhOibW5fWdtUTfL/WDMKynGq5d5EDyv2Yp8ivkXEG8
        5k+qy2MQbAe7WBeMB98PsjicYoINEhDlLRjgfEEdg9SisTssGr48NwOoD1CezvVf
        ngOWdpPZeBlDbDjrtDg0a97ggk2rzWU51JL+c+DKMU=
Received: from smtpclient.apple (unknown [223.148.66.180])
        by zwqz-smtp-mta-g1-4 (Coremail) with SMTP id _____wCH+tgPF0ZkeRhFCQ--.58262S2;
        Mon, 24 Apr 2023 13:43:44 +0800 (CST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Hao Ge <gehao618@163.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V2] fs: fix undefined behavior in bit shift for SB_NOUSER
Date:   Mon, 24 Apr 2023 13:43:33 +0800
Message-Id: <FA638ECE-96E4-4898-A457-76A621BE1860@163.com>
References: <20230424050158.GN3390869@ZenIV>
Cc:     Hao Ge <gehao@kylinos.cn>, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230424050158.GN3390869@ZenIV>
To:     Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: iPhone Mail (20E252)
X-CM-TRANSID: _____wCH+tgPF0ZkeRhFCQ--.58262S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF18Cw1fCry5Aw1DGw4fGrg_yoW8Jw4fpr
        yfKFnFkayUJwsFvw42qF15J3WvqanxAFyDGr9agw17A3Wj9w12vF4xK3W5uFy2krWrJFy5
        JFWUCFn5u3yvva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2mhrUUUUU=
X-Originating-IP: [223.148.66.180]
X-CM-SenderInfo: 5jhkt0qwryqiywtou0bp/1tbiExRbFmE1617+DQAAsY
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 24, 2023, at 13:02, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> =EF=BB=BFOn Mon, Apr 24, 2023 at 12:51:22PM +0800, Hao Ge wrote:
>> Shifting signed 32-bit value by 31 bits is undefined, so changing
>> significant bit to unsigned. The UBSAN warning calltrace like below:
>=20
>> UBSAN: shift-out-of-bounds in fs/nsfs.c:306:32
>> left shift of 1 by 31 places cannot be represented in type 'int'
>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-rc4+ #2
>> Call trace:
>> <TASK>
>> dump_backtrace+0x134/0x1e0
>> show_stack+0x2c/0x3c
>> dump_stack_lvl+0xb0/0xd4
>> dump_stack+0x14/0x1c
>> ubsan_epilogue+0xc/0x3c
>> __ubsan_handle_shift_out_of_bounds+0xb0/0x14c
>> nsfs_init+0x4c/0xb0
>> start_kernel+0x38c/0x738
>> __primary_switched+0xbc/0xc4
>> </TASK>
>>=20
>> Fixes: e462ec50cb5f ("VFS: Differentiate mount flags (MS_*) from internal=
 superblock flags")
>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>=20
> *snort*
>=20
> IMO something like "spotted by UBSAN" is more than enough here -
> stack trace is completely pointless.
>=20
> Otherwise, no problems with the patch - it's obviously safe.
Thanks for taking time to review this patch.
I fully agree with your suggestion, as it is not just this one place that re=
ported this error, although they are the same reason.
I will remove stack trace and send v3.


