Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7D271F3FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 22:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjFAUin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 16:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjFAUim (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:38:42 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E926813E
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 13:38:39 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-33b0ad1027aso10641775ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jun 2023 13:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685651919; x=1688243919;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abFcT4+hDaiL7vl8OJ3SqlfajtLNvtNMMTdrV5w1YEs=;
        b=ORtTSGdn0AJ1DYj/TblU+438jDrHjxBuKlHkcSDuBOWfSkase8DYafx6sgD/MxWVsf
         v/GfJ6IHAzalzZPGSUkFOEia+svsImItyW4HJKwd/W1+zfbf76EnRlniNmWfD2eQbQJq
         BadASVmV2hXyUOB/1zChGZ+1cF4WUzVrZ6dxiuaDGy4mjORJkC5uBev7h3A06Ot6aoiR
         zgMh9oY2x92oBlBXGZgE5NNUjrXXR2R99EZ/Z74BLCiNXfCXTTnJEPWnIpGXlsugiP4/
         asBhFZ8OD7Gxzk9+HdaRSid7cGZHm1olwZa3CWi7QNDReFzZwkBQoLzw4RA+2OdFa71s
         fQNw==
X-Gm-Message-State: AC+VfDzjaVmknuKUrXrCFyHaMItS3dM/oGCuZdEZ/1YtVUBoYv/mUSxO
        dVt9yn3QkB2Fn9IHFMPL8A960v2O7zDdXewD/LKJu8YWL/yO
X-Google-Smtp-Source: ACHHUZ4mES9mMqLcqY4/ltDAP65fIJ5pUXbWdR7w/ZbmJ03JHOgDKUP6/2iyiQFWhfCdpZ/4HP7e6dMELDh8utjSqjE5gqzNQOjd
MIME-Version: 1.0
X-Received: by 2002:a92:d581:0:b0:331:9a82:33f8 with SMTP id
 a1-20020a92d581000000b003319a8233f8mr3146924iln.3.1685651919186; Thu, 01 Jun
 2023 13:38:39 -0700 (PDT)
Date:   Thu, 01 Jun 2023 13:38:39 -0700
In-Reply-To: <8a48ede1-3a45-7c3c-39e9-36001ac09283@huaweicloud.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbb63805fd176bc6@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in open_xa_dir
From:   syzbot <syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com>
To:     hdanton@sina.com, jack@suse.cz, jeffm@suse.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, reiserfs-devel@vger.kernel.org,
        roberto.sassu@huawei.com, roberto.sassu@huaweicloud.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/reiserfs/namei.c
patch: **** unexpected end of file in patch



Tested on:

commit:         929ed21d Merge tag '6.4-rc4-smb3-client-fixes' of git:..
git tree:       upstream
dashboard link: https://syzkaller.appspot.com/bug?extid=8fb64a61fdd96b50f3b8
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10efc079280000

