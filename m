Return-Path: <linux-fsdevel+bounces-30425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C18A98AFA1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 00:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8CD51F23579
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 22:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370FB18859F;
	Mon, 30 Sep 2024 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U72BxDVx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05259187FEA
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734054; cv=none; b=fX/KOyOxzYPrTulkzMBNbI25gi3F2Na8+6IbLZWSNjIYlU9uPY6HkXwadmiaJGtKnyl8UBxfZr81txQtYtJZ9/jorbyzBMAAHnsrXan7z5cfAi1tEElWPIxk55HDBj6M2hTMraZ+qAdz8KifrMIPt5qYluKUx+baXcTR0R0pk4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734054; c=relaxed/simple;
	bh=9MMb93B0YoOJGZi3j0/eHqxNMpyqEeSfV+E7wrXa9WA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkYWGGGx9a8OFhal33ZVMleRlYDLdjSoDGk8W6ypWeDy1QEaxn7VgySidgamyTk+XhZkeZto5gbwPSkFjqPDQUi23j8Q4RcIPZ80NGqirYJJGgVnNhi3Ax1szH71Odia/sRf0MBhI6iRuAr31tDmRUfRSA+D+aS7w41vsCZay1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U72BxDVx; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a27668e995so15968455ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 15:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727734051; x=1728338851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WYWB6ck21hfg7kf4DvL90EazN+L3YGbsymLDPk7ZUWk=;
        b=U72BxDVxCTYfLYRFE3/5JgCFe8PzjMrE8gySwxCq9OV4qasJOAp1NZwvE7XJaVrfk+
         bDvYwiY657ZwY2nahuAWt168IijIfC4FCfjQse75tnmasCOShcAComPLRO0XX5MmeY+e
         ChJBpP3wWhauzKoaiAgcVIkkZoKewnWeodqwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727734051; x=1728338851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYWB6ck21hfg7kf4DvL90EazN+L3YGbsymLDPk7ZUWk=;
        b=Wr/qLM0WmcXFzU/QNmpCchvIB8KscvzyjhCNp0ALmCILlAJvRql7pB5DDlOw3PwFmi
         YB9qZdE+6NN1+r5/1ra0KYJokV0854fmBMUA0KuKnHg+pUofr/9OhGlM/C3/oT6HxRtP
         1sjkwrqtSqQh6UcF5nMZ99BBK0d0Lj0W+Yf/IWtskcVeJfWP7xVM5HGyvuEii6klh7oQ
         vNurxvYW3y7vtveXSi/qmJNBQtLd4KFR/7BjueFs+sk4n5qGlIkr3CPBI4YZZRXU5yow
         f+ytCxd6KAfwCAH9AvciLT0MS2GcEftn6OzIT5ViW5OSJIPkqlfSakStKl4vHG33Ez7f
         Oklw==
X-Gm-Message-State: AOJu0YzktaRF5Q8LCHiIuPqfRUjNuTE4qmVuIbcsTKcXDUl5V6MGNbvj
	WN1Rrm4gdUkdztf9rpy7mmZuASFwUBzkcnP8F3m7dYrckOAba8LgyYBJWn7URuA=
X-Google-Smtp-Source: AGHT+IHo0HAh3V5iXcgFC/M87lTOL8MFsHXMiHdslKu3aca8DWShDBmNHLIM0fFHVJzIS93dQryJ2A==
X-Received: by 2002:a05:6e02:1c29:b0:3a1:f549:7272 with SMTP id e9e14a558f8ab-3a3452bdca2mr104174335ab.23.1727734050988;
        Mon, 30 Sep 2024 15:07:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344d871b0sm27364075ab.36.2024.09.30.15.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 15:07:30 -0700 (PDT)
Message-ID: <d98b1040-d53f-408a-8a6c-b8e16688d5af@linuxfoundation.org>
Date: Mon, 30 Sep 2024 16:07:29 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/proc/proc-empty-vm.c: Test for unmapped process
To: Siddharth Menon <simeddon@gmail.com>, shuah@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240930160955.28502-1-simeddon@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240930160955.28502-1-simeddon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 10:09, Siddharth Menon wrote:
> Check if VMsize is 0 to determine whether the process has been unmapped.
> The child process cannot signal the parent that it has unmapped itself,
> as it no longer exists. This includes unmapping the text segment,
> preventing the child from proceeding to the next instruction.

Short log: Add test for unmapped process instead of "Test for"

Also you can include just: selftests/proc in shortlog and mention
the routine you care fixing.

Are you fixing a TODO? Mention that as well and cleanup the
TODO since it is fixed.

> 
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> ---
>   tools/testing/selftests/proc/proc-empty-vm.c | 50 ++++++++++++++++++++
>   1 file changed, 50 insertions(+)
> 
> diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
> index b3f898aab4ab..8ee000b0ddd7 100644
> --- a/tools/testing/selftests/proc/proc-empty-vm.c
> +++ b/tools/testing/selftests/proc/proc-empty-vm.c
> @@ -213,6 +213,53 @@ static void vsyscall(void)
>   }
>   #endif
>   
> +static int test_proc_pid_mem(pid_t pid)
> +{
> +	char buf[4096];
> +	char *line;
> +	int vm_size = -1;
> +
> +	snprintf(buf, sizeof(buf), "/proc/%d/status", pid);
> +	int fd = open(buf, O_RDONLY);
> +
> +	if (fd == -1) {
> +		if (errno == ENOENT) {
> +			// Process does not exist

This isn't the right comment block - please refer to coding style doc
in the repo. Maintain the comment style in this file.

> +			return EXIT_SUCCESS;
> +		}
> +	perror("open /proc/[pid]/status");
> +	return EXIT_FAILURE;
> +	}
> +
> +	ssize_t rv = read(fd, buf, sizeof(buf) - 1);
> +
> +	if (rv == -1) {
> +		perror("read");

Change this
> +		close(fd);
> +		return EXIT_FAILURE;
> +	}
> +	buf[rv] = '\0';
> +
> +	line = strtok(buf, "\n");
> +	while (line != NULL) {
> +		// Check for VmSize

Same here

> +		if (strncmp(line, "VmSize:", 7) == 0) {
> +			sscanf(line, "VmSize: %d", &vm_size);
> +			break;
> +		}
> +		line = strtok(NULL, "\n");
> +	}
> +
> +	close(fd);
> +
> +	// Check if VmSize is 0

Same here

> +	if (vm_size == 0) {
> +		return EXIT_SUCCESS;
> +	}
> +

Did you run checkpatch - you don't need { } for a single line
conditional.

> +	return EXIT_FAILURE;
> +}
> +
>   static int test_proc_pid_maps(pid_t pid)
>   {
>   	char buf[4096];
> @@ -508,6 +555,9 @@ int main(void)
>   		 */
>   		sleep(1);
>   
> +		if (rv == EXIT_SUCCESS) {
> +			rv = test_proc_pid_mem(pid);
> +		}
>   		if (rv == EXIT_SUCCESS) {
>   			rv = test_proc_pid_maps(pid);
>   		}

Also add everybody get_maintianer.pl suggests when you send v2.
You are missing key reviewers and maintainers.

thanks,
-- Shuah

