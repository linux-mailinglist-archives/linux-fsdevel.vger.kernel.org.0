Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10C2B15CD6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 22:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgBMVon (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 16:44:43 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35092 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMVom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 16:44:42 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so8698219edv.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 13:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6iMkJnmuaDOT/nQ8QyRCzJW1DxHpPU5cNxqRI+5goo=;
        b=PIw7E5FK5uMGQSQO8wbpPUp6f5T9D17OUGexKYbXdtUQttg7lkFcb7ZrY7zxqkJuF7
         IUDTTxfFWuajXiDFDWQXvBELPs2+KOoqds7y/MldWSq0di1ROQs14wpIC16aAbnzux9Y
         qTBvzLrg6gTeYg5Wb+/fgQXuupbE2u9OV73zEr2tujxtHYiZ2igPBO+L0RiCnuBbY33H
         JTGxZFfAlWsYu5+0uaqBK6gTlPgjcJoCWGD1613byRZSuN+WJYaIWoSr865H09zNQXZ4
         iJ2yQcaJmzck0TPBQtlzrJJ61lJ/sdUV7Mkch0Em0zgoL4IjpU8MKonw+E3A6AI+Grt1
         Ly8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6iMkJnmuaDOT/nQ8QyRCzJW1DxHpPU5cNxqRI+5goo=;
        b=EMqlQyYynxTcazXKiabWN2yG3/IduN6TvAmBEXRykdEzWIwhIx60f/V6oUVubdw8hG
         iZ/2aJJS6E8Zw95LRFMXSfa7jsjBMVh65Mj6o2dy0n7wRMzneByfdM6gU3l5oViyMbr3
         KI67AOE5V+YKgETwB189km+qzPLzZ8fiHouiSjVjIjNSP6vzervw/8Z1gZK5OncBuZeE
         hYIr8xJITz107hCm58GUPyNfoHZNVmfrcrE269QKF2ZOnMqUrlLCU3xSJ8HQ/zyF7YY6
         5oQsdwO3fkBG6Tzysg0rVQp4c8bahgv6yy1ZvUEN94r35W3DXF0BO0Gr1dx+ycFL7pbs
         kJKA==
X-Gm-Message-State: APjAAAVBWEdiI5WX1ta1qqMVMi174xphlvqJHniRY+9EvFjv+uBzIiDf
        putHvZn/qaIsH1V6DhoqC6uIyU2grcLMW//Sv+WI
X-Google-Smtp-Source: APXvYqzivqkXBB8NR1AVMPaykKlw/9vR8JhyBC59wFMjKjm5evBAVa6TlImCpH9hT3l8uI72hnHie5UbgBWCB+RdQRU=
X-Received: by 2002:aa7:db55:: with SMTP id n21mr16664962edt.31.1581630280853;
 Thu, 13 Feb 2020 13:44:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577736799.git.rgb@redhat.com> <20200204231454.oxa7pyvuxbj466fj@madcap2.tricolour.ca>
 <CAHC9VhQquokw+7UOU=G0SsD35UdgmfysVKCGCE87JVaoTkbisg@mail.gmail.com>
 <3142237.YMNxv0uec1@x2> <CAHC9VhTiCHQbp2SwK0Xb1QgpUZxOQ26JKKPsVGT0ZvMqx28oPQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTiCHQbp2SwK0Xb1QgpUZxOQ26JKKPsVGT0ZvMqx28oPQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Feb 2020 16:44:29 -0500
Message-ID: <CAHC9VhS09b_fM19tn7pHZzxfyxcHnK+PJx80Z9Z1hn8-==4oLA@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 07/16] audit: add contid support for signalling
 the audit daemon
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     linux-audit@redhat.com, Richard Guy Briggs <rgb@redhat.com>,
        nhorman@tuxdriver.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        simo@redhat.com, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        mpatel@redhat.com, Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a bit of a thread-hijack, and for that I apologize, but
another thought crossed my mind while thinking about this issue
further ... Once we support multiple auditd instances, including the
necessary record routing and duplication/multiple-sends (the host
always sees *everything*), we will likely need to find a way to "trim"
the audit container ID (ACID) lists we send in the records.  The
auditd instance running on the host/initns will always see everything,
so it will want the full container ACID list; however an auditd
instance running inside a container really should only see the ACIDs
of any child containers.

For example, imagine a system where the host has containers 1 and 2,
each running an auditd instance.  Inside container 1 there are
containers A and B.  Inside container 2 there are containers Y and Z.
If an audit event is generated in container Z, I would expect the
host's auditd to see a ACID list of "1,Z" but container 1's auditd
should only see an ACID list of "Z".  The auditd running in container
2 should not see the record at all (that will be relatively
straightforward).  Does that make sense?  Do we have the record
formats properly designed to handle this without too much problem (I'm
not entirely sure we do)?

-- 
paul moore
www.paul-moore.com
