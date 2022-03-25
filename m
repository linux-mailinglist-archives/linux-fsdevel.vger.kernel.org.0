Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EAD4E6E52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 07:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358485AbiCYGoO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 02:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347663AbiCYGoO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 02:44:14 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CB6C6ED0;
        Thu, 24 Mar 2022 23:42:41 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id c11so5689699pgu.11;
        Thu, 24 Mar 2022 23:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=c41pCClCkN5PFuk+yVxjeXx2WWOwThCPdPC/YOqI5Oc=;
        b=FKHElwsSShqv1oat3UyiSLvlerb5qeYV4ERQ2SvkMp/1V3ZR3vKzzZH8C9IPiS0p24
         4wtOlQPUE/4yepppcqaxxeK8uU0Diwceiw7CyOtFLclTHEj3jU3cD5Nq8Jbi166gMMh8
         IoJPUpzASBVj6+bNdutkjscnWW6DivrFw4h6xeR6M5Py58sRjlk8ntzrwRQ6/onOHyNS
         xWuJ07r9TGK1VOydTfcFt7O12lE8OAo7X4zNF65o3R5oMEQp+b88FonNe9Egk3GUm+OP
         RXA5HEo2jZkSCHkU7wc34JQQN70oNrU5/HoxcCD7q/cj8qqEXlbCJPnOevHf1K4wph0p
         4/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=c41pCClCkN5PFuk+yVxjeXx2WWOwThCPdPC/YOqI5Oc=;
        b=SosZx99AHXhUvpppxReeAFtOPxFHPWBgquZfE4URd21HW85UXOyBeSgUoiT3Ygsb4I
         BZfaXw5bz5jxj9LBYEosZBxg+5vVS4uDtuW3xfnN5rvllJmiYDB7Nr2r9jU+/4EYj5Q4
         wDD5j1/6WpoIy/sPZ7ry4YXw7s5Eg8e5x7SrT5yacRotsaOzBmwQXhP7flQE5z9Dw7b/
         KNEsVbr0p2KTBrwnkNJ7DenCyWWmBsMz5WofB7JNDNqXn3KaeSf7AX1/z3dkjkV0hWHW
         bdbCYJbvLoyEHCiHfkYGXbQJaVbVy3WmN4QcmJGAySKajSTMbk4s9FhSr1o9FOL5yTMf
         vEMQ==
X-Gm-Message-State: AOAM532RTO72nA2yo1ICtfAaYyDl8cGOz7RE9lGRRd5ni/KZ0jlppBUI
        V9l1st7Hf2TZOBdWgmw1dF9qI394pWE1v34HRM/A+J4Lcu9to8S0
X-Google-Smtp-Source: ABdhPJyIT7qv0mAbLagqCyRC41PfqZxQ6pA+YeAp0PgGt0MQSoJ24RfjHgfRqr5gZRQW/XuBozVtUALpyXPOUsVNc5Y=
X-Received: by 2002:aa7:86c6:0:b0:4fa:46d:6005 with SMTP id
 h6-20020aa786c6000000b004fa046d6005mr9010671pfo.86.1648190560379; Thu, 24 Mar
 2022 23:42:40 -0700 (PDT)
MIME-Version: 1.0
From:   Fariya F <fariya.fatima03@gmail.com>
Date:   Fri, 25 Mar 2022 12:12:30 +0530
Message-ID: <CACA3K+i8nZRBxeTfdy7Uq5LHAsbZEHTNati7-RRybsj_4ckUyw@mail.gmail.com>
Subject: df returns incorrect size of partition due to huge overhead block
 count in ext4 partition
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

My eMMC partition is ext4 formatted and has about 100MB size. df -h
command lists the size of the partition and the used percentage as
below.
    Filesystem           Size  Used Avail Use% Mounted on

    /dev/mmcblk2p4    16Z   16Z   79M 100% /data

For your reference, the returned values for statfs64( ) are

statfs64("/data", 88, {f_type="EXT2_SUPER_MAGIC", f_bsize=1024,
f_blocks=18446744073659310077, f_bfree=87628, f_bavail=80460,
f_files=25688, f_ffree=25189, f_fsid={-1446355608, 1063639410},
f_namelen=255, f_frsize=1024, f_flags=4128}) = 0

The output dumpe2fs returns the following


    Block count:              102400

    Reserved block count:     5120

    Overhead blocks:          50343939

As per my kernel (4.9.31) code, the f_blocks is block_count - overhead
blocks. Considering the subtraction with the above values results in a
negative value this is interpreted as the huge value of
18446744073659310077.

I have a script which monitors the used percentage of the partition
using df -h command and when the used percentage is greater than 70%,
it deletes files until the used percentage comes down. Considering df
is reporting all the time 100% usage, all my files get deleted.

My questions are:

a) Where does overhead blocks get set?

b) Why is this value huge for my partition and how to correct it
considering fsck is also not correcting this

Please note fsck on this partition doesn't report any issues at all.

I am also able to create files in this partition.
