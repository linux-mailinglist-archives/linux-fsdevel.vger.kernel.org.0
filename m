Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B451D7EBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 20:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfJOSRw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 14:17:52 -0400
Received: from tretyak2.mcst.ru ([212.5.119.215]:43608 "EHLO tretyak2.mcst.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbfJOSRw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:17:52 -0400
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Oct 2019 14:17:51 EDT
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
        by tretyak2.mcst.ru (Postfix) with ESMTP id BEE6420BF9
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2019 21:09:08 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [172.16.4.50])
        by tretyak2.mcst.ru (Postfix) with ESMTP id A7AB720A29
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2019 21:09:03 +0300 (MSK)
Received: from [192.168.1.7] (e2k7 [192.168.1.7])
        by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id x9FI92At026633
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2019 21:09:02 +0300
To:     linux-fsdevel@vger.kernel.org
From:   "Pavel V. Panteleev" <panteleev_p@mcst.ru>
Subject: copy_mount_options() problem
Message-ID: <5DA60B3E.5080303@mcst.ru>
Date:   Tue, 15 Oct 2019 21:09:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 7bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
         bases: 20111107 #2745587, check: 20191015 notchecked
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

copy_mount_options() checks that data doesn't cross TASK_SIZE boundary. 
It's not correct. Really it should check USER_DS boudary, because some 
archs have TASK_SIZE not equal to USER_DS. In this case (USER_DS != 
TASK_SIZE) exact_copy_from_user() will stop on access_ok() check, if 
data cross USER_DS, but doesn't cross TASK_SIZE.

Best regards,
Pavel V. Panteleev
