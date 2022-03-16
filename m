Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3774DB1C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 14:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348443AbiCPNrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 09:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241647AbiCPNrE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:47:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE935D65B;
        Wed, 16 Mar 2022 06:45:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F188E1F38A;
        Wed, 16 Mar 2022 13:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647438347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+41MFpKRhqNaQrWRi+ngw6IHebcbmsk9SqhRzEgY4gI=;
        b=FULCV+NTmRSfcme8M/VF5SzcGZFFOrp6lLSpW6Lm1mgbulqHj1ZGzumfmBGna2rwEuMXaa
        XABD0kT/EhICC05Zk6tYEnlslRUGeUQLJ3Omi5TS+1eycx2f/fwl+Y6joalnb9Us/oLbU7
        HPeWGYw5c325OnHcmGnPfUQxO0UDkh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647438347;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+41MFpKRhqNaQrWRi+ngw6IHebcbmsk9SqhRzEgY4gI=;
        b=1wcK8B/1rxo/P1AU6eROXdFEIeR/cSE9y09MmLZ5N4YM9w7CxDj61D0RC4Hgm6xmfELABl
        FzJvXUHHbxPUvGCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BDB6F13322;
        Wed, 16 Mar 2022 13:45:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nZIBLQvqMWK6dgAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 16 Mar 2022 13:45:47 +0000
Date:   Wed, 16 Mar 2022 14:45:46 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp\" <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>"@imap2.suse-dmz.suse.de
Cc:     'Vasant Karasulli' <vkarasulli@suse.de>,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Takashi Iwai' <tiwai@suse.de>,
        'Namjae Jeon' <linkinjeon@kernel.org>
Subject: Re: [PATCH v2 2/2] exfat currently unconditionally strips trailing
 periods '.' when performing path lookup, but allows them in the filenames
 during file creation. This is done intentionally, loosely following Windows
 behaviour and specifications which ...
Message-ID: <20220316144546.2da266c3@suse.de>
In-Reply-To: <TYAPR01MB535314A6E1FB0CB1BAD621C2900F9@TYAPR01MB5353.jpnprd01.prod.outlook.com>
References: <20220310142455.23127-1-vkarasulli@suse.de>
        <20220310142455.23127-3-vkarasulli@suse.de>
        <20220310210633.095f0245@suse.de>
        <CAKYAXd_ij3WqJHQZvH458XRwLBtboiJnr-fK0hVPDi_j_8XDZQ@mail.gmail.com>
        <YisU2FA7EBeguwN5@vasant-suse>
        <TYAPR01MB535314A6E1FB0CB1BAD621C2900F9@TYAPR01MB5353.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi T.Kohada,

On Mon, 14 Mar 2022 03:52:08 +0000, Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp wrote:

> Hi, Vasant Karasulli.
> 
> > > > I think it makes sense to mention your findings from the Windows
> > > > tests here. E.g. "Windows 10 also retains leading and trailing space
> > > > characters".  
> > > Windows 10 do also strip them. So you can make another patch to strip
> > > it as well as trailing periods.  
> > Actually I found contradicting behavior between Window 10 File Explorer and Commandline. Commandline seems to strip
> > trailing spaces, but File Explorer doesn't.  
> 
> The exfat specification specifies an invalid character set, but there are no restrictions on the use of leading or trailing white-space or dots.
> Even if the filename has trailing-dot as shown below, it conforms to the exfat specification and can be created on Windows.
> "a"
> "a."
> "a.."
> These are treated as "a" in the current implementation of linix-exfat, so the intended file cannot be accessed.
> The specified filename should not be modified to comply with the exfat specification.
> Therefore, exfat_striptail_len() should not be used.
> 
> Note:
> Windows explorer removes trailing white-space and dots, but not the behavior of the filesystem.
> Also, you can create a trailing-dot filename by quoting it on the command line.

Please explain how you came to that conclusion.
I did some further tests using the win32 CopyFile() API directly[1] on
Windows10 and observe that both trailing periods and trailing spaces are
trimmed for an exfat destination path.

Cheers, David

1: calling win32 CopyFile() from powershell
https://devblogs.microsoft.com/scripting/use-powershell-to-interact-with-the-windows-api-part-1/
