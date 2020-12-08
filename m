Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B5C2D28CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 11:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgLHK2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 05:28:16 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:60237 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgLHK2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:28:16 -0500
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0B8ARD1X008734;
        Tue, 8 Dec 2020 19:27:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Tue, 08 Dec 2020 19:27:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0B8ARDxs008729
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Dec 2020 19:27:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2 00/10] allow unprivileged overlay mounts
To:     Miklos Szeredi <mszeredi@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <1725e01a-4d4d-aecb-bad6-54aa220b4cd2@i-love.sakura.ne.jp>
Date:   Tue, 8 Dec 2020 19:27:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201207163255.564116-1-mszeredi@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/12/08 1:32, Miklos Szeredi wrote:
> A general observation is that overlayfs does not call security_path_*()
> hooks on the underlying fs.  I don't see this as a problem, because a
> simple bind mount done inside a private mount namespace also defeats the
> path based security checks.  Maybe I'm missing something here, so I'm
> interested in comments from AppArmor and Tomoyo developers.

Regarding TOMOYO, I don't want overlayfs to call security_path_*() hooks on the
underlying fs, but the reason is different. It is not because a simple bind mount
done inside a private mount namespace defeats the path based security checks.
TOMOYO does want to check what device/filesystem is mounted on which location. But
currently TOMOYO is failing to check it due to fsopen()/fsmount()/move_mount() API.

