Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BF81EA4C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 15:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgFANR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 09:17:28 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53621 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFANR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:17:27 -0400
Received: by mail-pj1-f67.google.com with SMTP id i12so970071pju.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2020 06:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hFZ6VmcYqyPM08PfvBVOlGIssxARKDDkBROacFfg5Ck=;
        b=hvqaUx7Qhk53+L19sg0UtST4epmx5BK+FtEJ/EFthOIpppJmgNPyISTCIbEKngWbGr
         QDDCL8DbS/usjHdiKh7PXrvX0RS4J4Yi7kUtpctH8hXv+LF4oHMlH7WYa10LkYI4DKl4
         oKr5BNWBf3l+auJjM202EQkQM/wxxGYar4bUqo67zta9xaNjyHOJg0D731A3c7xLok1g
         Gz3qRoPaggIprx9DwvFIk3nc14uFrS39xh/obD3mqsAjX/aMT5JfAQSpVcod76tDnN4m
         JeVdwPCwbbuUy3ZlfIGuBs7+axngpbS17jNDduYUa+z7WocjQohgZ1kKuyRjawKQz0qC
         FgIw==
X-Gm-Message-State: AOAM533RVtYbpW3fyLigNqLI/sQ2w1E0Gbb+KKIA9+lgtO+8lZPOA+23
        nqUjb3ky4cqAwWDfeLWNrys=
X-Google-Smtp-Source: ABdhPJxw2rn3wia9BIDzDW1zUAIYizzEPtrFPk5f1QOIArACW42sqTfGX6xND0ZcqRubWo1Br/ii4A==
X-Received: by 2002:a17:90a:8594:: with SMTP id m20mr1189463pjn.38.1591017447030;
        Mon, 01 Jun 2020 06:17:27 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id b1sm4969011pjc.33.2020.06.01.06.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 06:17:25 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 84F2740251; Mon,  1 Jun 2020 13:17:24 +0000 (UTC)
Date:   Mon, 1 Jun 2020 13:17:24 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Boris Sukholitko <boris.sukholitko@broadcom.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, keescook@chromium.org,
        yzaikin@google.com
Subject: Re: [PATCH] __register_sysctl_table: do not drop subdir
Message-ID: <20200601131724.GK11244@42.do-not-panic.com>
References: <20200527104848.GA7914@nixbox>
 <20200527125805.GI11244@42.do-not-panic.com>
 <20200528080812.GA21974@noodle>
 <874ks02m25.fsf@x220.int.ebiederm.org>
 <20200528142045.GP11244@42.do-not-panic.com>
 <20200531114432.GB22327@noodle>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531114432.GB22327@noodle>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 31, 2020 at 02:44:32PM +0300, Boris Sukholitko wrote:
> On Thu, May 28, 2020 at 02:20:45PM +0000, Luis Chamberlain wrote:
> > On Thu, May 28, 2020 at 09:04:02AM -0500, Eric W. Biederman wrote:
> > > I see some recent (within the last year) fixes to proc_sysctl.c in this
> > > area.  Do you have those?  It looks like bridge up and down is stressing
> > > this code.  Either those most recent fixes are wrong, your kernel is
> > > missing them or this needs some more investigation.
> > 
> > Thanks for the review Eric.
> > 
> 
> Seconded. My first try at fixing it was incorrect, hopefully the new
> attempt ([PATCH] get_subdir: do not drop new subdir if returning it)
> I've just sent will fare better.
> 
> > Boris, the elaborate deatils you provided would also be what would be
> > needed for a commit log, specially since this is fixing a crash. If
> > you confirm this is still present upstream by reproducing with a test
> > case it would be wonderful.
> 
> Yes. It is present in the upstream kernel. In my patch I've added
> warning to catch this bad condition. The warning fires easily during
> boot.

Can you add a test case for this to reproduce in lib/test_sysct.c?

  Luis
