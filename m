Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 483AC188C8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 18:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgCQRvs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 13:51:48 -0400
Received: from smtp-42a8.mail.infomaniak.ch ([84.16.66.168]:58731 "EHLO
        smtp-42a8.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726555AbgCQRvs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:51:48 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4884010045F29;
        Tue, 17 Mar 2020 18:51:46 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (ns3096276.ip-94-23-54.eu [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 48hghx0Jy5zls2l2;
        Tue, 17 Mar 2020 18:51:45 +0100 (CET)
Subject: Re: [RFC PATCH v14 06/10] landlock: Add syscall implementation
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
References: <20200224160215.4136-1-mic@digikod.net>
 <20200224160215.4136-7-mic@digikod.net>
 <20200317164709.GA23230@ZenIV.linux.org.uk>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <a0f52aed-7234-59d3-35ea-98ae9d8a23ae@digikod.net>
Date:   Tue, 17 Mar 2020 18:51:44 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20200317164709.GA23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 17/03/2020 17:47, Al Viro wrote:
> On Mon, Feb 24, 2020 at 05:02:11PM +0100, Mickaël Salaün wrote:
> 
>> +static int get_path_from_fd(u64 fd, struct path *path)
> 
>> +	/*
>> +	 * Only allows O_PATH FD: enable to restrict ambiant (FS) accesses
>> +	 * without requiring to open and risk leaking or misuing a FD.  Accept
>> +	 * removed, but still open directory (S_DEAD).
>> +	 */
>> +	if (!(f.file->f_mode & FMODE_PATH) || !f.file->f_path.mnt ||
> 					      ^^^^^^^^^^^^^^^^^^^
> Could you explain what that one had been be about?  The underlined
> subexpression is always false; was that supposed to check some
> condition and if so, which one?
> 

This was just to be sure that the next assignment "path->mnt =
f.file->f_path.mnt;" always creates a valid path. If this is always
true, I will remove it.
