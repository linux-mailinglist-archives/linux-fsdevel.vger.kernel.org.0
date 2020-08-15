Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0282245284
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Aug 2020 23:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgHOVwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Aug 2020 17:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbgHOVwZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:25 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD79BC0F26FC
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2020 11:15:49 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id f193so6096266pfa.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2020 11:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cgr9lRuKidkQIN9VikhOAh92WJNaoQaxLNAuYBGK56A=;
        b=e6PWsULuK1ZSnLzAcLaCBxDm6omzMQsVIJecKyrN7HSU4hXEnzWV60RwOx7FNce0Hj
         Ke+ZSTpcDU3JIhDtJRiZvJgsp122dUidCpvjhkRKTwv4T2amwjdG2UIi79GZF9VbMCRc
         Ic8PK+2wuWD2Bm6eQZbWs8D3M+V9nhh2hzO1z95l3MlCIRKCGscsoer6Qj6nDTn2LmPA
         4Zb19YxRviqttOYunp4fH/bLzZvrkhQVnFyHcwGDJTPLf2C0W7BZQ0DYeqM9vBfrf65i
         5A8NFr8SWQ9gJwZpKTSRbtl/NV2ezk4rIYpB93OYN6gxUYxpSekq7y8hqke+WXPgT2WU
         YH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cgr9lRuKidkQIN9VikhOAh92WJNaoQaxLNAuYBGK56A=;
        b=UmBeouCCoZKdSmlTpwd4K1UzabH8MQI2hB4I/QTsYYBKw4LbmDTg5au1VGCLmwEdBn
         Y4lz26cGl5ZNji8iPhXN3Zl3ekQVQRU66ckJPw40R7ybQhPtoU5ECz+ltmYBwgPbxKI6
         Ni1/RQm06hJgIdW8F0sOR7hr5zIIf2e/xcH6aHCjh89S4sd1SsCt06PkC6SjKN34EYec
         R+Nb6zaThkUys0k0vTc4M+j/un+rOcNTG1rhRqRZ4Lkz6lUncJ5JDJdiVwfupYQLT5LN
         xc9LM36rnwMgeCmGMdU+ZWTQE1+VQm/KPZ3MOlU4N6k1Wh6/mQGw/wfYLM6pryG6K0Lo
         Qj0A==
X-Gm-Message-State: AOAM532GwKVWst1CsfC/YnW0wSW1hdSDJvkrKXQRyYGCtrJs+FKx0ZAA
        jBet4Gra8Ke0HF4XGoHjZnExLg==
X-Google-Smtp-Source: ABdhPJzM1CZhjXBL0TtrdKhbrHniS7YBWuX7Am0ORQZPsO3178OMkcj+cFPwslOf9e4QBeTzu5pGhQ==
X-Received: by 2002:a62:8cd3:: with SMTP id m202mr5746565pfd.184.1597515346498;
        Sat, 15 Aug 2020 11:15:46 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:6299:2df1:e468:6351? ([2605:e000:100e:8c61:6299:2df1:e468:6351])
        by smtp.gmail.com with ESMTPSA id z77sm13633210pfc.199.2020.08.15.11.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Aug 2020 11:15:45 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: Re: possible deadlock in io_poll_double_wake
To:     syzbot <syzbot+0d56cfeec64f045baffc@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <000000000000923cee05acee6f61@google.com>
Message-ID: <f9436b5a-c8d5-1c45-3039-6e2ddea3a313@kernel.dk>
Date:   Sat, 15 Aug 2020 11:15:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000923cee05acee6f61@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz dup general protection fault in io_poll_double_wake

-- 
Jens Axboe

