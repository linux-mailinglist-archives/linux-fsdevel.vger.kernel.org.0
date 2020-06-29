Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEF220E887
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 00:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgF2WMg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 18:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgF2WMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:12:35 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C171C061755;
        Mon, 29 Jun 2020 15:12:35 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id 35so7648612ple.0;
        Mon, 29 Jun 2020 15:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bYbnK/1xSCVq1/TiUVXXGtkJjMs/M1Q7KN0EtGsVY6o=;
        b=QGGZu2c4OuikWTRSNeoe1sVM3jGJOC1AUrzjW5WMAQvvuH9XL+s1wpFivhaniiLEx9
         6NZSaIGqhCzd2ykSYS1W4q5M0bwY8B9KZq82eYI88v/NWkm9FC8VcubCh2qCmdp3gmUF
         N6zR5kwYnq7Ar8uTIsswnVYWdH8c+IWLnf6Sr69rCa+GY2Ce0LW6ixZ96NMmUAHji/wj
         fRKp+Ea8+q1atMhnQ4bpScUYSWdMEGqJ3K6iaZvh/Mmw6zupppbQQC3YPOD7Ur4Gs3Iz
         oCM4IGld1+je/nS1r2/OKSmScpyzGj3A254T4DmwGHMZBYPadtzyZs4UYKJ1cnF7/K0U
         IDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bYbnK/1xSCVq1/TiUVXXGtkJjMs/M1Q7KN0EtGsVY6o=;
        b=JN7wj/kJj00cpzHQuR53iIlG5fhr/Ottj9/aTaqUiYnx71JIIcjrhTyq7wyG+rBBoK
         nRjF3r0SUTR8MGiEJVYdcJk8sBoohPZOucXKPZHJfQBaxlbaX345lqTHpfQz4i78IHGg
         +kPyJdCn/yBCtadHKq/meetBBsXeW7cLipRIXDiuf09EKWtE3lsFFOQ3dY+qTIS5Col9
         Vj4wqraTRHA/WTMayfL+8C3D/W310rOf8HZcDESIsFeCb/rbsgDMTszSL01M6QcTZ2Sp
         5qjrRhS9Dq5x4H458kqzF0yTaCK46sX+D7Ex3mOV2tvg7vYF0HVjuSLKjGOE/xsvf5hR
         bTWg==
X-Gm-Message-State: AOAM530Ez5SdgemWMm71rVzRcsOwk/56HrNA2kKU7UTM4Pd/kw7Q1QDR
        PiRRrYhwFP2TR+vEwXQFQ4W0Kqge
X-Google-Smtp-Source: ABdhPJxOc+HpDNzP+2988YFqOG8eD5PnPjzwgrx3K2bOdH27XDD3MYifNIiTyYCfMU3Elj4SI7z0KA==
X-Received: by 2002:a17:90b:1c12:: with SMTP id oc18mr18176746pjb.160.1593468754943;
        Mon, 29 Jun 2020 15:12:34 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:592])
        by smtp.gmail.com with ESMTPSA id cv3sm419878pjb.45.2020.06.29.15.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 15:12:34 -0700 (PDT)
Date:   Mon, 29 Jun 2020 15:12:31 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 00/15] Make the user mode driver code a better citizen
Message-ID: <20200629221231.jjc2czk3ul2roxkw@ast-mbp.dhcp.thefacebook.com>
References: <20200625095725.GA3303921@kroah.com>
 <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com>
 <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
 <87y2oac50p.fsf@x220.int.ebiederm.org>
 <87bll17ili.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bll17ili.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 29, 2020 at 02:55:05PM -0500, Eric W. Biederman wrote:
> 
> I have tested thes changes by booting with the code compiled in and
> by killing "bpfilter_umh" and running iptables -vnL to restart
> the userspace driver.
> 
> I have compiled tested each change with and without CONFIG_BPFILTER
> enabled.

With
CONFIG_BPFILTER=y
CONFIG_BPFILTER_UMH=m
it doesn't build:

ERROR: modpost: "kill_pid_info" [net/bpfilter/bpfilter.ko] undefined!

I've added:
+EXPORT_SYMBOL(kill_pid_info);
to continue testing...

And then did:
while true; do iptables -L;rmmod bpfilter; done
 
Unfortunately sometimes 'rmmod bpfilter' hangs in wait_event().

I suspect patch 13 is somehow responsible:
+	if (tgid) {
+		kill_pid_info(SIGKILL, SEND_SIG_PRIV, tgid);
+		wait_event(tgid->wait_pidfd, !pid_task(tgid, PIDTYPE_TGID));
+		bpfilter_umh_cleanup(info);
+	}

I cannot figure out why it hangs. Some sort of race ?
Since adding short delay between kill and wait makes it work.
