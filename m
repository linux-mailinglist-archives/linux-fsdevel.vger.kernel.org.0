Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480023C91CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 22:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbhGNUIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 16:08:43 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:54436 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241096AbhGNUH0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:07:26 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m3l7Q-007pwB-Bs; Wed, 14 Jul 2021 14:04:32 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:50472 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m3l7M-00A6qN-Bp; Wed, 14 Jul 2021 14:04:29 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Rafa?? Mi??ecki <zajec5@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <30c7ec73-4ad5-3c4e-4745-061eb22f2c8a@redhat.com>
        <CAHk-=wjW7Up3KD-2EqVg7+ca8Av0-rC5Kd7yK+=m6Dwk3D4Q+A@mail.gmail.com>
        <YO30DKw5FKLz4QuF@zeniv-ca.linux.org.uk>
        <bea2bcf2-02f6-f247-9e06-7b9ec154377a@gmail.com>
        <YO755O8JnxG44YaT@kroah.com>
        <7f4a96bc-3912-dfb6-4a32-f0c6487d977b@gmail.com>
        <20210714161352.GA22357@magnolia> <YO8OP7vzHIuKvO6X@infradead.org>
Date:   Wed, 14 Jul 2021 15:03:38 -0500
In-Reply-To: <YO8OP7vzHIuKvO6X@infradead.org> (Christoph Hellwig's message of
        "Wed, 14 Jul 2021 17:18:07 +0100")
Message-ID: <87v95c1x45.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m3l7M-00A6qN-Bp;;;mid=<87v95c1x45.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+dzvyCIcpSAmwrYPzxInUIyP1DR/wobKA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4609]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Christoph Hellwig <hch@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 284 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.9 (1.4%), b_tie_ro: 2.7 (0.9%), parse: 0.62
        (0.2%), extract_message_metadata: 8 (2.8%), get_uri_detail_list: 0.43
        (0.2%), tests_pri_-1000: 11 (4.0%), tests_pri_-950: 1.02 (0.4%),
        tests_pri_-900: 0.84 (0.3%), tests_pri_-90: 100 (35.2%), check_bayes:
        98 (34.6%), b_tokenize: 3.8 (1.3%), b_tok_get_all: 6 (2.2%),
        b_comp_prob: 1.05 (0.4%), b_tok_touch_all: 84 (29.6%), b_finish: 0.72
        (0.3%), tests_pri_0: 147 (51.8%), check_dkim_signature: 0.37 (0.1%),
        check_dkim_adsp: 2.3 (0.8%), poll_dns_idle: 0.94 (0.3%), tests_pri_10:
        1.74 (0.6%), tests_pri_500: 7 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> also we still have a huge backlog in the switch to the new mount API.
                                                         ^^^^^^^^^^^^^^
Speaking of code that ignored reviewer feedback.

Part of my feedback was that the new mount API has problems that make
it difficult to switch to.

Or is it your point that we let the new mount API be merged without a
conversion for all filesystems and a promise that the conversion would
get done after it was merged?

Eric

