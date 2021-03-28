Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840ED34BBC3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Mar 2021 11:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhC1JMK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Mar 2021 05:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhC1JLy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Mar 2021 05:11:54 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2771C061762;
        Sun, 28 Mar 2021 02:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID;
        bh=jSDB76cKI45AnX0KGZxYz6mDtclIJTURQk2j8oHwPlo=; b=qX4JpVuA+TfC6
        AxKdbzmxUD0LGqSE60Gher5H7rwu1qos8FwUDgaJ6Ot1AY1S8oSu2pdt/wNKq+hZ
        pVDMkCsOyMPEda/q4bofLOGz9arm3hu1zlr2O+hAKMbPK0kEhDeFE5xPssrKr9oS
        Brd71zIR5ECkGEAnhEkADyQ3t3T+rQ=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Sun, 28 Mar
 2021 17:11:43 +0800 (GMT+08:00)
X-Originating-IP: [203.184.132.238]
Date:   Sun, 28 Mar 2021 17:11:43 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG] fs/notify/mark: A potential use after free in
 fsnotify_put_mark_wake
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2021 www.mailtech.cn ustc-xl
X-SendMailWithSms: false
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <39095113.1936a.178781a774a.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygBnb0tPSGBgJjNdAA--.0W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQoOBlQhn5fqvwABsq
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
    My static analyzer tool reported a use after free in fsnotify_put_mark_wake
of the file: fs/notify/mark.c.

In fsnotify_put_mark_wake, it calls fsnotify_put_mark(mark). Inside the function
fsnotify_put_mark(), if conn is NULL, it will call fsnotify_final_mark_destroy(mark)
to free mark->group by fsnotify_put_group(group) and return. I also had inspected
the implementation of fsnotify_put_group() and found that there is no cleanup operation
about group->user_waits.

But after fsnotify_put_mark_wake() returned, mark->group is still used by 
if (atomic_dec_and_test(&group->user_waits) && group->shutdown) and later.

Is this an issue?

Thanks.





