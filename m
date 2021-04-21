Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7ACA36751C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 00:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbhDUWXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 18:23:44 -0400
Received: from mail.tuxforce.de ([84.38.66.179]:39794 "EHLO mail.tuxforce.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235192AbhDUWXo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 18:23:44 -0400
Received: from [IPv6:2001:4dd5:b099:0:19b2:6b8c:f4bb:b22d] (2001-4dd5-b099-0-19b2-6b8c-f4bb-b22d.ipv6dyn.netcologne.de [IPv6:2001:4dd5:b099:0:19b2:6b8c:f4bb:b22d])
        by mail.tuxforce.de (Postfix) with ESMTPSA id 130BB520082;
        Thu, 22 Apr 2021 00:23:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.tuxforce.de 130BB520082
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tuxforce.de;
        s=202009; t=1619043789;
        bh=8FNnf+br7d/DLoSUqDX/HFRUhYb+osidIocRZ6RLu64=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=N6YCBq9oqEzT1RtnHZRYpOQDqv7LQl/jLZ+oVAHovkPQGAMmn81H1v6ZVlnIdV1dx
         7gzDd86jUkKeJdpjjcgzbXWSL2HwW+Cco/yqmH2CaK8359xpHXWQhCJtNBOfZlMGVQ
         +jRw53iNsuS5mDbmd0XWAENDkTRPDL+zVVNdJm8y9iA7bSxMwdanNwZjFLDcSyeJHH
         Zc2PKA8J026IeQtKgEgN3+u2mtcoUFtfdMSIt5yKqlqSSLRySrBTCV8ZMiShXSxGyg
         +YdIJUUC0JWEjmZyCNjTovukqWLOQ3xKNQJL9vVqK1bpDMaiiWr9MQSPHPxICR0DGh
         jGsO2tCVx9fHw==
Subject: Re: [PATCH 1/2] test_firmware: add suspend support to test buggy
 drivers
To:     Luis Chamberlain <mcgrof@kernel.org>, rafael@kernel.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        bvanassche@acm.org, jeyu@kernel.org, ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lukas Middendorf <kernel@tuxforce.de>
References: <20210416235850.23690-1-mcgrof@kernel.org>
 <20210416235850.23690-2-mcgrof@kernel.org>
From:   Lukas Middendorf <kernel@tuxforce.de>
Message-ID: <3ef0de52-5d17-c950-942f-29932df54880@tuxforce.de>
Date:   Thu, 22 Apr 2021 00:23:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210416235850.23690-2-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 17/04/2021 01:58, Luis Chamberlain wrote:
> Lukas Middendorf reported a situation where a driver's
> request_firmware() call on resume caused a stall. Upon
> inspection the issue was that the driver in question was
> calling request_firmware() only on resume, and since we
> currently do not have a generic kernel VFS freeze / thaw
> solution in place we are allowing races for filesystems
> to race against the disappearance of a block device, and
> this is presently an issue which can lead to a stall.
> 
> It is difficult to reproduce this unless you have hardware
> which mimics this setup. So to test this setup, let's just
> implement support for doing these wacky things. This lets
> us test that corner case easily as follows.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

The resume test functionality added to test_firmware works as intended 
in reproducing the stall bug I reported.

However, the fw_test_resume.sh seems to be incomplete.

> +usage()
> +{
> +	echo "Usage: $0 [ -v ] | [ -h | --help]"
> +	echo ""
> +	echo "    --check-resume-test   Verify resume test"
> +	echo "    -h|--help             Help"
> +	echo
> +	echo "Without any arguments this will enable the resume firmware test"
> +	echo "after suspend. To verify that the test went well, run with -v".
> +	echo
> +	exit 1
> +}

The "-v" is not implemented as an alias to "--check-resume-test"

> +
> +verify_resume_test()
> +{
> +	trap "test_finish" EXIT
> +}

Does not seem to do anything regarding checking, just some cleanup.

> +
> +parse_args()
> +{
> +	if [ $# -eq 0 ]; then
> +		config_enable_resume_test
> +	else
> +		if [[ "$1" = "--check-resume-test" ]]; then
> +			config_disable_resume_test
> +			verify_resume_test
> +		else
> +			usage
> +		fi
> +	fi
> +}
> +

there should likely be a call

parse_args "$@"

> +exit 0

